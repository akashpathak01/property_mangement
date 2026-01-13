import React, { useState } from 'react';
import { MainLayout } from '../layouts/MainLayout';
import { Eye, RotateCcw, X } from 'lucide-react';
import { Button } from '../components/Button';

const PaymentsReceived = () => {
  const [payments] = useState([
    {
      id: 'INV-301-APR',
      tenant: 'John Doe',
      unit: 'Unit 301 - Bedroom 1',
      type: 'Bedroom',
      amount: 18000,
      method: 'Bank Transfer',
      date: '03 Apr 2026',
      status: 'Paid',
    },
    {
      id: 'INV-202-APR',
      tenant: 'ABC Pvt Ltd',
      unit: 'Unit 202',
      type: 'Full Unit',
      amount: 50000,
      method: 'UPI',
      date: '02 Apr 2026',
      status: 'Paid',
    },
  ]);

  const [selectedPayment, setSelectedPayment] = useState(null);

  return (
    <MainLayout title="Payments Received">
      <div className="p-0">

        {/* TABLE */}
        <div className="bg-white rounded-xl shadow-[0_10px_30px_rgba(0,0,0,0.06)] overflow-hidden border border-gray-100">
          <table className="w-full border-collapse">
            <thead>
              <tr>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Invoice</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Tenant</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Unit</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Amount</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Method</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Date</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Status</th>
                <th className="p-4 bg-slate-50 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider border-b border-gray-100">Action</th>
              </tr>
            </thead>

            <tbody>
              {payments.map((p) => (
                <tr key={p.id} className="hover:bg-slate-50 transition-colors">
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700 font-mono">{p.id}</td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{p.tenant}</td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{p.unit}</td>
                  <td className="p-4 border-b border-gray-100 text-sm font-medium font-mono">₹{p.amount}</td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{p.method}</td>
                  <td className="p-4 border-b border-gray-100 text-sm text-slate-700">{p.date}</td>
                  <td className="p-4 border-b border-gray-100 text-sm">
                    <span className="px-2.5 py-1 rounded-full text-xs font-semibold border bg-emerald-50 text-emerald-700 border-emerald-100">{p.status}</span>
                  </td>
                  <td className="p-4 border-b border-gray-100 text-sm">
                    <div className="flex gap-2">
                      <button onClick={() => setSelectedPayment(p)} className="p-1.5 text-slate-500 hover:text-primary-600 hover:bg-slate-100 rounded-md transition-colors">
                        <Eye size={16} />
                      </button>
                      <button title="Refund (future)" className="p-1.5 text-slate-500 hover:text-orange-600 hover:bg-slate-100 rounded-md transition-colors">
                        <RotateCcw size={16} />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* VIEW PAYMENT MODAL */}
        {selectedPayment && (
          <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50 backdrop-blur-sm animate-in fade-in">
            <div className="bg-white p-6 rounded-xl w-[520px] shadow-2xl animate-in zoom-in-95">
              <div className="flex items-center justify-between mb-6 pb-3 border-b border-slate-100">
                <h3 className="text-lg font-bold text-slate-800">Payment Details</h3>
                <button onClick={() => setSelectedPayment(null)} className="text-slate-400 hover:text-slate-600">
                  <X size={18} />
                </button>
              </div>

              <div className="grid grid-cols-2 gap-4 mb-6">
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Invoice No</label><span className="text-sm font-medium text-slate-900">{selectedPayment.id}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Tenant</label><span className="text-sm font-medium text-slate-900">{selectedPayment.tenant}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Unit</label><span className="text-sm font-medium text-slate-900">{selectedPayment.unit}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Lease Type</label><span className="text-sm font-medium text-slate-900">{selectedPayment.type}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Payment Method</label><span className="text-sm font-medium text-slate-900">{selectedPayment.method}</span></div>
                <div className="flex flex-col"><label className="text-xs text-slate-500 mb-1">Paid On</label><span className="text-sm font-medium text-slate-900">{selectedPayment.date}</span></div>

                <div className="col-span-2 mt-2 p-4 rounded-lg bg-emerald-50 text-center text-xl font-bold text-emerald-800 border border-emerald-100">
                  ₹{selectedPayment.amount}
                </div>
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <Button variant="secondary" onClick={() => setSelectedPayment(null)}>
                  Close
                </Button>
                <Button>
                  Download Receipt
                </Button>
              </div>
            </div>
          </div>
        )}

      </div>
    </MainLayout>
  );
};

export default PaymentsReceived;
