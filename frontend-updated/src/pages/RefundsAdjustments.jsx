import React, { useState } from 'react';
import { MainLayout } from '../layouts/MainLayout';
import { Eye, X } from 'lucide-react';
import { Button } from '../components/Button';

const RefundsAdjustments = () => {
  const [records] = useState([
    {
      id: 'RA-001',
      type: 'Refund',
      reason: 'Security Deposit Refund',
      tenant: 'John Doe',
      unit: 'Unit 301',
      amount: 25000,
      date: '15 Apr 2026',
      status: 'Completed',
    },
    {
      id: 'RA-002',
      type: 'Adjustment',
      reason: 'Rent Discount',
      tenant: 'Aman Verma',
      unit: 'Unit 301 – Bedroom 2',
      amount: -2000,
      date: '18 Apr 2026',
      status: 'Applied',
    },
    {
      id: 'RA-003',
      type: 'Refund',
      reason: 'Overpayment Refund',
      tenant: 'XYZ Logistics Pvt Ltd',
      unit: 'Unit 202',
      amount: 5000,
      date: '20 Apr 2026',
      status: 'Pending',
    },
  ]);

  const [selected, setSelected] = useState(null);

  return (
    <MainLayout title="Refunds & Adjustments">
      <div className="p-0">

        <div className="bg-white rounded-xl shadow-[0_10px_30px_rgba(0,0,0,0.06)] overflow-hidden border border-gray-100">
          <table className="w-full border-collapse">
            <thead>
              <tr>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">ID</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Type</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Reason</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Tenant</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Unit</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Amount</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Date</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Status</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Action</th>
              </tr>
            </thead>

            <tbody>
              {records.map((r) => (
                <tr key={r.id} className="hover:bg-slate-50 transition-colors">
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700 font-mono">{r.id}</td>
                  <td className="p-4 border-b border-gray-100 text-sm">
                    <span className={`px-2.5 py-1 rounded-full text-xs font-semibold border ${r.type === 'Refund'
                      ? 'bg-cyan-50 text-cyan-700 border-cyan-100'
                      : 'bg-yellow-50 text-yellow-700 border-yellow-100'
                      }`}>
                      {r.type}
                    </span>
                  </td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{r.reason}</td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{r.tenant}</td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{r.unit}</td>
                  <td className={`p-4 border-b border-gray-100 text-sm font-medium font-mono ${r.amount < 0 ? 'text-amber-700' : 'text-slate-700'}`}>
                    ${Math.abs(r.amount).toLocaleString('en-CA')}
                  </td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{r.date}</td>
                  <td className="p-4 border-b border-gray-100 text-sm">
                    <span className={`px-2.5 py-1 rounded-full text-xs font-semibold border ${r.status === 'Completed' ? 'bg-emerald-50 text-emerald-700 border-emerald-100' :
                      r.status === 'Applied' ? 'bg-yellow-50 text-yellow-700 border-yellow-100' :
                        'bg-orange-50 text-orange-700 border-orange-100' // Pending
                      }`}>
                      {r.status}
                    </span>
                  </td>
                  <td className="p-4 border-b border-gray-100 text-sm">
                    <button onClick={() => setSelected(r)} className="p-1.5 text-slate-500 hover:text-primary-600 hover:bg-slate-100 rounded-md transition-colors">
                      <Eye size={16} />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* VIEW MODAL */}
        {selected && (
          <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50 backdrop-blur-sm animate-in fade-in">
            <div className="bg-white p-6 rounded-xl w-[520px] shadow-2xl animate-in zoom-in-95">
              <div className="flex items-center justify-between mb-6 pb-3 border-b border-slate-100">
                <h3 className="text-lg font-bold text-slate-800">{selected.type} Details</h3>
                <button onClick={() => setSelected(null)} className="text-slate-400 hover:text-slate-600">
                  <X size={20} />
                </button>
              </div>

              <div className="grid grid-cols-2 gap-4 mb-6">
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">ID</label><span className="text-sm font-medium text-slate-900">{selected.id}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Tenant</label><span className="text-sm font-medium text-slate-900">{selected.tenant}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Unit</label><span className="text-sm font-medium text-slate-900">{selected.unit}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Type</label><span className="text-sm font-medium text-slate-900">{selected.type}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Reason</label><span className="text-sm font-medium text-slate-900">{selected.reason}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Date</label><span className="text-sm font-medium text-slate-900">{selected.date}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Status</label><span className="text-sm font-medium text-slate-900">{selected.status}</span></div>

                <div className={`col-span-2 mt-2 p-4 rounded-lg text-center text-xl font-bold border ${selected.amount < 0
                  ? 'bg-yellow-50 text-yellow-800 border-yellow-100'
                  : 'bg-cyan-50 text-cyan-800 border-cyan-100'
                  }`}>
                  ${Math.abs(selected.amount).toLocaleString('en-CA')}
                </div>
              </div>

              <div className="flex justify-end pt-2">
                <Button variant="secondary" onClick={() => setSelected(null)}>
                  Close
                </Button>
              </div>
            </div>
          </div>
        )}

      </div>
    </MainLayout>
  );
};

export default RefundsAdjustments;
