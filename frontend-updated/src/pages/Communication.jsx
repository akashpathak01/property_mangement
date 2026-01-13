import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { MainLayout } from '../layouts/MainLayout';
import { Mail, MessageSquare, Users, Send, CheckCircle2, History, ExternalLink, Clock } from 'lucide-react';
import { Button } from '../components/Button';
import clsx from 'clsx';
import api from '../api/client';

export const Communication = () => {
    const navigate = useNavigate();
    const [activeTab, setActiveTab] = useState('email');
    const [showSuccess, setShowSuccess] = useState(false);
    const [formData, setFormData] = useState({
        recipient: 'all',
        subject: '',
        message: '',
    });

    const tenants = [
        { id: 1, name: 'John Smith', unit: '301' },
        { id: 2, name: 'ABC Pvt Ltd', unit: '402 (Bedroom 2)' },
        { id: 3, name: 'Maria Garcia', unit: '105' },
    ];

    const [commHistory, setCommHistory] = useState([]);

    React.useEffect(() => {
        fetchHistory();
    }, []);

    const fetchHistory = async () => {
        try {
            const res = await api.get('/admin/communication');
            setCommHistory(res.data);
        } catch (e) { console.error(e); }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await api.post('/admin/communication', {
                recipient: formData.recipient === 'all' ? 'All Tenants' : 'Selected Tenants', // Simplified for demo
                subject: activeTab === 'email' ? formData.subject : 'SMS Message',
                message: formData.message,
                type: activeTab === 'email' ? 'Email' : 'SMS'
            });
            setShowSuccess(true);
            setTimeout(() => setShowSuccess(false), 3000);
            setFormData({ recipient: 'all', subject: '', message: '' });
            fetchHistory();
        } catch (e) {
            alert('Failed to send');
        }
    };

    return (
        <MainLayout title="Communication Center">
            <div className="p-6 max-w-4xl mx-auto">
                {/* Tabs */}
                <div className="flex gap-1 bg-slate-100 p-1 rounded-xl mb-8 w-fit">
                    <button
                        onClick={() => setActiveTab('email')}
                        className={clsx(
                            "flex items-center gap-2 px-6 py-2.5 rounded-lg text-sm font-bold transition-all",
                            activeTab === 'email' ? "bg-white text-indigo-600 shadow-sm" : "text-slate-500 hover:text-slate-700"
                        )}
                    >
                        <Mail size={18} />
                        Email
                    </button>
                    <button
                        onClick={() => setActiveTab('sms')}
                        className={clsx(
                            "flex items-center gap-2 px-6 py-2.5 rounded-lg text-sm font-bold transition-all",
                            activeTab === 'sms' ? "bg-white text-indigo-600 shadow-sm" : "text-slate-500 hover:text-slate-700"
                        )}
                    >
                        <MessageSquare size={18} />
                        SMS
                    </button>
                    <button
                        onClick={() => setActiveTab('history')}
                        className={clsx(
                            "flex items-center gap-2 px-6 py-2.5 rounded-lg text-sm font-bold transition-all",
                            activeTab === 'history' ? "bg-white text-indigo-600 shadow-sm" : "text-slate-500 hover:text-slate-700"
                        )}
                    >
                        <History size={18} />
                        History
                    </button>
                </div>

                <div className="bg-white rounded-2xl shadow-xl shadow-slate-200/50 border border-slate-100 overflow-hidden">
                    <div className="p-6 border-b border-slate-50 bg-slate-50/30 flex justify-between items-center">
                        <div>
                            <h2 className="text-xl font-black text-slate-800 tracking-tight">
                                {activeTab === 'email' ? 'Compose Bulk Email' :
                                    activeTab === 'sms' ? 'Compose Bulk SMS' : 'Communication History'}
                            </h2>
                            <p className="text-sm text-slate-500 font-medium whitespace-nowrap overflow-hidden text-ellipsis">
                                {activeTab === 'history' ? 'Overview of all sent communications' : 'Message will be sent to selected recipients.'}
                            </p>
                        </div>
                    </div>

                    {activeTab === 'history' ? (
                        <div className="overflow-x-auto">
                            <table className="w-full text-left border-collapse">
                                <thead>
                                    <tr className="bg-slate-50/50 border-b border-slate-100">
                                        <th className="px-8 py-4 text-[10px] font-black text-slate-400 uppercase tracking-widest">Date & Time</th>
                                        <th className="px-8 py-4 text-[10px] font-black text-slate-400 uppercase tracking-widest">Recipient</th>
                                        <th className="px-8 py-4 text-[10px] font-black text-slate-400 uppercase tracking-widest">Channel</th>
                                        <th className="px-8 py-4 text-[10px] font-black text-slate-400 uppercase tracking-widest">Summary</th>
                                        <th className="px-8 py-4 text-[10px] font-black text-slate-400 uppercase tracking-widest">Status</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-50">
                                    {commHistory.map(item => (
                                        <tr key={item.id} className="hover:bg-slate-50/50 transition-colors group">
                                            <td className="px-8 py-5">
                                                <div className="flex items-center gap-2 text-slate-500">
                                                    <Clock size={14} />
                                                    <span className="text-xs font-bold">{item.date}</span>
                                                </div>
                                            </td>
                                            <td className="px-8 py-5">
                                                <label className="flex flex-col">
                                                    <span
                                                        onClick={() => {
                                                            if (item.tenant !== 'All Tenants') {
                                                                const tenantObj = tenants.find(t => t.name === item.tenant);
                                                                if (tenantObj) navigate(`/tenants/${tenantObj.id}`);
                                                                else navigate('/tenants');
                                                            }
                                                        }}
                                                        className={clsx(
                                                            "text-sm font-black text-slate-800 italic transition-colors flex items-center gap-1",
                                                            item.tenant !== 'All Tenants' ? "cursor-pointer hover:text-indigo-600 hover:underline" : "cursor-default"
                                                        )}
                                                    >
                                                        {item.tenant}
                                                        {item.tenant !== 'All Tenants' && <ExternalLink size={12} className="opacity-0 group-hover:opacity-100 transition-opacity" />}
                                                    </span>
                                                </label>
                                            </td>
                                            <td className="px-8 py-5">
                                                <div className="flex items-center gap-2">
                                                    {item.channel === 'Email' ? <Mail size={14} className="text-indigo-400" /> : <MessageSquare size={14} className="text-slate-400" />}
                                                    <span className="text-xs font-bold text-slate-600">{item.channel}</span>
                                                </div>
                                            </td>
                                            <td className="px-8 py-5">
                                                <p className="text-xs text-slate-500 font-medium truncate max-w-[200px]">{item.summary}</p>
                                            </td>
                                            <td className="px-8 py-5">
                                                <span className="px-2.5 py-1 rounded-full bg-emerald-100 text-emerald-700 text-[10px] font-black uppercase tracking-widest">
                                                    {item.status}
                                                </span>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                            {commHistory.length === 0 && (
                                <div className="p-20 text-center text-slate-400 italic">No communication history found.</div>
                            )}
                        </div>
                    ) : (
                        <form onSubmit={handleSubmit} className="p-8 space-y-6">
                            {/* Recipient Selection */}
                            <div className="space-y-3">
                                <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest px-1">Recipients</label>
                                <div className="grid grid-cols-2 gap-4">
                                    <button
                                        type="button"
                                        onClick={() => setFormData({ ...formData, recipient: 'all' })}
                                        className={clsx(
                                            "flex items-center gap-3 p-4 rounded-xl border-2 transition-all text-left",
                                            formData.recipient === 'all' ? "border-indigo-600 bg-indigo-50/50" : "border-slate-100 hover:border-slate-200"
                                        )}
                                    >
                                        <div className={clsx("w-5 h-5 rounded-full border-2 flex items-center justify-center", formData.recipient === 'all' ? "border-indigo-600 bg-indigo-600" : "border-slate-300")}>
                                            {formData.recipient === 'all' && <div className="w-2 h-2 rounded-full bg-white" />}
                                        </div>
                                        <div>
                                            <p className="font-bold text-slate-800 text-sm italic">All Tenants</p>
                                            <p className="text-[10px] text-slate-500">Sends to all 42 active tenants</p>
                                        </div>
                                    </button>
                                    <button
                                        type="button"
                                        onClick={() => setFormData({ ...formData, recipient: 'selected' })}
                                        className={clsx(
                                            "flex items-center gap-3 p-4 rounded-xl border-2 transition-all text-left",
                                            formData.recipient === 'selected' ? "border-indigo-600 bg-indigo-50/50" : "border-slate-100 hover:border-slate-200"
                                        )}
                                    >
                                        <div className={clsx("w-5 h-5 rounded-full border-2 flex items-center justify-center", formData.recipient === 'selected' ? "border-indigo-600 bg-indigo-600" : "border-slate-300")}>
                                            {formData.recipient === 'selected' && <div className="w-2 h-2 rounded-full bg-white" />}
                                        </div>
                                        <div>
                                            <p className="font-bold text-slate-800 text-sm italic">Selected Tenants</p>
                                            <p className="text-[10px] text-slate-500">Pick specific tenants from list</p>
                                        </div>
                                    </button>
                                </div>
                            </div>

                            {formData.recipient === 'selected' && (
                                <div className="p-4 bg-slate-50 rounded-xl border border-slate-100 space-y-3">
                                    <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest px-1">Select Recipients</label>
                                    <div className="flex flex-wrap gap-2">
                                        {tenants.map(t => (
                                            <label key={t.id} className="flex items-center gap-2 bg-white px-3 py-1.5 rounded-lg border border-slate-200 cursor-pointer hover:border-indigo-300 transition-colors">
                                                <input type="checkbox" className="rounded text-indigo-600 focus:ring-indigo-500" defaultChecked />
                                                <span className="text-xs font-bold text-slate-700">{t.name} <span className="text-slate-400 font-medium">({t.unit})</span></span>
                                            </label>
                                        ))}
                                    </div>
                                </div>
                            )}

                            {activeTab === 'email' && (
                                <div className="space-y-2">
                                    <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest px-1">Email Subject</label>
                                    <input
                                        type="text"
                                        required
                                        value={formData.subject}
                                        onChange={(e) => setFormData({ ...formData, subject: e.target.value })}
                                        placeholder="e.g. Important Maintenance Update"
                                        className="w-full p-4 rounded-xl border border-slate-200 text-sm focus:outline-none focus:border-indigo-500 focus:ring-4 focus:ring-indigo-50 transition-all font-medium"
                                    />
                                </div>
                            )}

                            <div className="space-y-2">
                                <div className="flex justify-between items-center px-1">
                                    <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">{activeTab === 'email' ? 'Message' : 'SMS Content'}</label>
                                    {activeTab === 'sms' && (
                                        <span className={clsx("text-[10px] font-bold", charCount > 160 ? "text-rose-500" : "text-slate-400")}>
                                            {charCount} / 160 characters
                                        </span>
                                    )}
                                </div>
                                <textarea
                                    required
                                    value={formData.message}
                                    onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                                    placeholder={activeTab === 'email' ? "Type your email message here..." : "Type your SMS content (keep it brief)..."}
                                    rows={6}
                                    className="w-full p-4 rounded-xl border border-slate-200 text-sm focus:outline-none focus:border-indigo-500 focus:ring-4 focus:ring-indigo-50 transition-all font-medium resize-none"
                                />
                            </div>

                            <div className="pt-4">
                                <Button type="submit" className="w-full h-14 rounded-2xl font-black text-base shadow-xl shadow-indigo-100 flex items-center justify-center gap-3 group overflow-hidden relative">
                                    <span className="relative z-10">
                                        {activeTab === 'email' ? 'Send Bulk Email' : 'Send Bulk SMS'}
                                    </span>
                                    <Send size={20} className="relative z-10 group-hover:translate-x-1 group-hover:-translate-y-1 transition-transform" />
                                </Button>
                            </div>
                        </form>
                    )}
                </div>

                {/* Toast Notification */}
                {showSuccess && (
                    <div className="fixed bottom-8 left-1/2 -translate-x-1/2 bg-slate-900 text-white px-8 py-4 rounded-2xl shadow-2xl flex items-center gap-4 animate-in slide-in-from-bottom-5 duration-300 z-[200]">
                        <div className="w-8 h-8 rounded-full bg-emerald-500 flex items-center justify-center">
                            <CheckCircle2 size={18} className="text-white" />
                        </div>
                        <div>
                            <p className="font-bold text-sm tracking-tight">
                                {activeTab === 'email' ? 'Email Queued Successfully' : 'SMS Queued Successfully'}
                            </p>
                            <p className="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Demo Mode: No messages sent</p>
                        </div>
                    </div>
                )}
            </div>
        </MainLayout>
    );
};
