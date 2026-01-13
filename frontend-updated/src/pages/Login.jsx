import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

import api from '../api/client';

export const Login = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleLogin = async () => {
    try {
      setError('');
      setLoading(true);
      const res = await api.post('/auth/login', { email, password });

      const { accessToken, refreshToken, user } = res.data;

      localStorage.setItem('accessToken', accessToken);
      localStorage.setItem('refreshToken', refreshToken);
      localStorage.setItem('user', JSON.stringify(user));
      localStorage.setItem('isLoggedIn', 'true'); // Keeping legacy flag for existing protected routes

      navigate('/dashboard');
    } catch (err) {
      console.error(err);
      setError(err.response?.data?.message || 'Login failed');
    } finally {
      setLoading(false);
    }
  };

  const autofillDemo = () => {
    setEmail('admin@property.com');
    setPassword('123456');
  };

  return (
    <div className="flex min-h-screen bg-slate-50">
      {/* LEFT IMAGE */}
      <div className="hidden md:flex flex-1 relative bg-cover bg-center" style={{ backgroundImage: "url('https://images.unsplash.com/photo-1560185008-b033106af5c3')" }}>
        <div className="absolute inset-0 bg-gradient-to-b from-blue-600/75 to-blue-800/85 p-[60px] flex flex-col justify-center text-white">
          <h1 className="text-[42px] font-bold mb-3">ProPerty</h1>
          <p className="text-lg opacity-95">Smart Property & Rental Management</p>
        </div>
      </div>

      {/* RIGHT FORM */}
      <div className="w-full md:w-[420px] bg-white p-12 flex flex-col justify-center shadow-xl md:shadow-none">
        <h2 className="text-[28px] font-semibold mb-1.5 text-slate-900">Welcome Back</h2>
        <p className="text-sm text-slate-500 mb-8">Sign in to access your dashboard</p>

        {error && (
          <div className="mb-4 p-3 bg-red-50 text-red-600 text-sm rounded-md border border-red-100">
            {error}
          </div>
        )}

        <div className="flex flex-col mb-5">
          <label className="text-[13px] mb-1.5 text-slate-700">Email</label>
          <input
            type="email"
            placeholder="admin@property.com"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="h-[42px] px-3 rounded-md border border-slate-300 text-sm focus:outline-none focus:border-blue-600 focus:ring-3 focus:ring-blue-600/15 transition-all"
          />
        </div>

        <div className="flex flex-col mb-5">
          <label className="text-[13px] mb-1.5 text-slate-700">Password</label>
          <input
            type="password"
            placeholder="••••••"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="h-[42px] px-3 rounded-md border border-slate-300 text-sm focus:outline-none focus:border-blue-600 focus:ring-3 focus:ring-blue-600/15 transition-all"
          />
        </div>

        <button
          className="h-[44px] bg-blue-600 text-white border-0 rounded-md text-[15px] cursor-pointer mt-2.5 hover:bg-blue-700 transition-colors font-medium disabled:opacity-50 disabled:cursor-not-allowed"
          onClick={handleLogin}
          disabled={loading}
        >
          {loading ? 'Logging in...' : 'Login'}
        </button>

        <div className="mt-6 text-center space-y-2">
          <p className="text-sm text-slate-500 font-medium">
            Are you a tenant?{" "}
            <button
              onClick={() => navigate('/tenant/login')}
              className="text-blue-600 font-bold hover:underline cursor-pointer"
            >
              Login to Tenant Portal
            </button>
          </p>
          <p className="text-sm text-slate-500 font-medium border-t border-slate-50 pt-2">
            Are you an Owner?{" "}
            <button
              onClick={() => navigate('/owner/login')}
              className="text-blue-600 font-bold hover:underline cursor-pointer"
            >
              Login to Owner Portal
            </button>
          </p>
        </div>

        <div className="mt-7 bg-slate-100 p-3.5 rounded-md text-[13px] text-slate-600">
          <strong className="block mb-1 text-slate-900">Demo Credentials</strong>
          <p className="mb-0.5">Email: <span className="font-semibold text-slate-800">admin@property.com</span></p>
          <p className="mb-2">Password: <span className="font-semibold text-slate-800">123456</span></p>
          <button onClick={autofillDemo} className="bg-none border-0 text-blue-600 cursor-pointer p-0 text-[13px] hover:underline font-medium">Click to autofill</button>
        </div>
      </div>
    </div>
  );
};


