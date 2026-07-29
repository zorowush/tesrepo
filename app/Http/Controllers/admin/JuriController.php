<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;

class JuriController extends Controller
{
    public function index()
    {
        $juris = User::role('juri')->latest()->get();

        return inertia('Admin/Juris/Index', [
            'juris' => $juris,
        ]);
    }

    public function create()
    {
        return inertia('Admin/Juris/Form', [
            'juri' => null,
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name'      => ['required', 'string', 'max:255'],
            'email'     => ['required', 'email', 'max:255', Rule::unique('users', 'email')],
            'password'  => ['required', Password::min(8)->mixedCase()->symbols()->uncompromised()],
            'no_hp'     => ['nullable', 'string', 'max:30'],
            'is_active' => ['sometimes', 'boolean'],
        ]);

        // normalisasi checkbox biar pasti true/false murni
        $data['is_active'] = $request->boolean('is_active');
        $data['password']  = Hash::make($data['password']);
        $data['email_verified_at'] = now();

        $juri = User::create($data);
        $juri->assignRole('juri');

        return redirect()
            ->route('admin.juris.index')
            ->with('success', 'Akun juri berhasil dibuat.')
            ->setStatusCode(303); // pola 303 kayak Event, biar redirect jadi GET
    }

    public function edit(User $juri)
    {
        abort_unless($juri->hasRole('juri'), 404);

        return inertia('Admin/Juris/Form', [
            'juri' => $juri,
        ]);
    }

    public function update(Request $request, User $juri)
    {
        abort_unless($juri->hasRole('juri'), 404);

        $data = $request->validate([
            'name'      => ['required', 'string', 'max:255'],
            'email'     => ['required', 'email', 'max:255', Rule::unique('users', 'email')->ignore($juri->id)],
            'password'  => ['nullable', Password::min(8)->mixedCase()->symbols()->uncompromised()],
            'no_hp'     => ['nullable', 'string', 'max:30'],
            'is_active' => ['sometimes', 'boolean'],
        ]);

        $data['is_active'] = $request->boolean('is_active');

        // password kosong = jangan diubah
        if (empty($data['password'])) {
            unset($data['password']);
        } else {
            $data['password'] = Hash::make($data['password']);
        }

        $juri->update($data);

        return redirect()
            ->route('admin.juris.index')
            ->with('success', 'Akun juri berhasil diupdate.')
            ->setStatusCode(303);
    }

    public function destroy(User $juri)
    {
        abort_unless($juri->hasRole('juri'), 404);

        $juri->delete();

        return redirect()
            ->route('admin.juris.index')
            ->with('success', 'Akun juri berhasil dihapus.')
            ->setStatusCode(303);
    }
}