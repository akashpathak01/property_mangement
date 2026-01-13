import React, { useState } from 'react';
import { TenantLayout } from '../../layouts/TenantLayout';
import { ShieldCheck, AlertTriangle, Calendar, Info, Eye, X, FileText } from 'lucide-react';
import { Button } from '../../components/Button';

export const TenantInsurance = () => {
    const [showPreview, setShowPreview] = useState(false);

    return (
        <TenantLayout title="Insurance">
            <div className="max-w-4xl space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                {/* STATUS ALERT - EXPIRED STATE */}
                <div className="bg-red-50 border border-red-100 rounded-3xl p-6 flex flex-col md:flex-row gap-6 items-center justify-between shadow-sm">
                    <div className="flex gap-5 items-start">
                        <div className="w-12 h-12 bg-red-500 rounded-2xl flex items-center justify-center text-white shrink-0 shadow-lg shadow-red-100">
                            <AlertTriangle size={24} />
                        </div>
                        <div className="space-y-1">
                            <h3 className="text-lg font-black text-red-900 leading-tight">Action Required: Policy Expired</h3>
                            <p className="text-red-700/80 font-medium text-sm leading-relaxed">
                                Your policy # SF-12345 expired <span className="font-black">2 days ago</span>.
                                Please upload a renewed certificate to maintain compliance with your lease.
                            </p>
                        </div>
                    </div>
                </div>

                {/* POLICY CARDS */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <section className="bg-white rounded-3xl border-2 border-red-500 p-8 shadow-xl shadow-red-50 relative overflow-hidden">
                        <div className="absolute top-0 right-0 bg-red-500 text-white text-[10px] font-black uppercase tracking-widest px-4 py-1.5 rounded-bl-xl">
                            Expired
                        </div>

                        <div className="flex items-center gap-4 mb-8">
                            <div className="w-14 h-14 rounded-2xl bg-red-50 text-red-600 flex items-center justify-center border border-red-100 italic font-black text-xl">
                                SF
                            </div>
                            <div className="space-y-0.5">
                                <h3 className="text-lg font-black text-slate-800">State Farm</h3>
                                <p className="text-sm font-bold text-slate-400">Policy # SF-12345</p>
                            </div>
                        </div>

                        <div className="space-y-6">
                            <div className="flex items-center justify-between p-4 rounded-2xl bg-slate-50 border border-slate-100">
                                <div className="flex items-center gap-3">
                                    <Calendar size={18} className="text-slate-400" />
                                    <span className="text-xs font-black text-slate-400 uppercase tracking-widest">Expired On</span>
                                </div>
                                <span className="text-sm font-black text-red-600">Jan 05, 2026</span>
                            </div>

                            <div className="flex items-center gap-2.5 text-red-600 bg-red-50 p-4 rounded-2xl border border-red-100">
                                <AlertTriangle size={20} />
                                <span className="text-sm font-black uppercase tracking-tight">Non-Compliant</span>
                            </div>
                        </div>

                        <div className="grid grid-cols-2 gap-3 mt-6">
                            <button
                                onClick={() => setShowPreview(true)}
                                className="flex items-center justify-center gap-2 py-3.5 rounded-2xl border-2 border-slate-100 text-slate-600 font-bold hover:bg-slate-50 transition-all text-sm"
                            >
                                <Eye size={18} />
                                View Policy
                            </button>
                            <button className="py-3.5 rounded-2xl bg-primary-600 text-white font-bold hover:bg-primary-700 transition-all text-sm shadow-lg shadow-primary-50">
                                Upload New
                            </button>
                        </div>
                    </section>

                    <section className="bg-slate-50 rounded-3xl border border-slate-200 p-8 flex flex-col items-center justify-center text-center space-y-6 border-dashed">
                        <div className="w-16 h-16 bg-white rounded-full flex items-center justify-center text-slate-300 shadow-sm">
                            <ShieldCheck size={32} />
                        </div>
                        <div className="space-y-2">
                            <h4 className="font-bold text-slate-500 text-lg">Switch Provider</h4>
                            <p className="text-sm text-slate-400 font-medium px-4">
                                Switching to a new insurance company? Upload the new policy here.
                            </p>
                        </div>
                        <button className="px-6 py-3 rounded-xl bg-white border border-slate-200 text-slate-600 font-bold text-sm hover:border-primary-300 hover:text-primary-600 transition-all shadow-sm">
                            Compare Quotes
                        </button>
                    </section>
                </div>

                {/* HELP CARD */}
                <section className="bg-white rounded-3xl border border-slate-100 p-8 shadow-sm flex flex-col md:flex-row gap-8 items-center">
                    <div className="w-20 h-20 bg-blue-50 text-blue-600 rounded-3xl flex items-center justify-center shrink-0">
                        <Info size={36} />
                    </div>
                    <div className="space-y-2 flex-1">
                        <h3 className="text-xl font-black text-slate-800">Why do I need Insurance?</h3>
                        <p className="text-sm text-slate-500 font-medium leading-relaxed">
                            Tenant insurance protects your personal belongings and provides liability coverage if someone is injured in your unit. Most lease agreements require a minimum of $1M liability coverage.
                        </p>
                    </div>
                </section>
            </div>

            {/* DOCUMENT PREVIEW MODAL */}
            {showPreview && (
                <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-[100] flex items-center justify-center p-4 animate-in fade-in duration-300">
                    <div className="bg-white rounded-3xl w-full max-w-2xl overflow-hidden shadow-2xl animate-in zoom-in-95 duration-300">
                        <div className="p-6 border-b border-slate-50 flex items-center justify-between">
                            <div className="flex items-center gap-3">
                                <FileText className="text-primary" size={24} />
                                <h3 className="text-xl font-black text-slate-800 tracking-tight">State_Farm_Policy_Jan2026.pdf</h3>
                            </div>
                            <button onClick={() => setShowPreview(false)} className="p-2 text-slate-400 hover:bg-slate-50 rounded-xl transition-all">
                                <X size={24} />
                            </button>
                        </div>
                        <div className="p-12 h-[60vh] bg-slate-100 flex items-center justify-center">
                            <div className="text-center space-y-4">
                                <div className="w-20 h-20 bg-white rounded-3xl flex items-center justify-center mx-auto shadow-sm text-slate-300">
                                    <FileText size={40} />
                                </div>
                                <p className="text-slate-400 font-bold">PDF Preview Simulation</p>
                                <Button variant="primary">Download Actual PDF</Button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </TenantLayout>
    );
};
