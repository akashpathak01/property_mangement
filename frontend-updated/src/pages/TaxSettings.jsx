import { useState, useEffect } from 'react';
import { MainLayout } from '../layouts/MainLayout';
import api from '../api/client';

export const TaxSettings = () => {

  /* ---------------- STATE ---------------- */
  const [taxes, setTaxes] = useState([]);

  /* LOAD DATA */
  useEffect(() => {
    const fetchTaxes = async () => {
      try {
        const res = await api.get('/admin/settings');
        const s = res.data.settings || {};
        if (s.tax_configuration) {
          setTaxes(JSON.parse(s.tax_configuration));
        } else {
          // Default init if empty
          setTaxes([
            { name: 'GST', rate: 18, appliesTo: 'Rent', status: 'active' },
            { name: 'Service Tax', rate: 5, appliesTo: 'Maintenance', status: 'inactive' },
            { name: 'VAT', rate: 12, appliesTo: 'Utilities', status: 'active' },
          ]);
        }
      } catch (e) { console.error(e); }
    };
    fetchTaxes();
  }, []);

  const [showModal, setShowModal] = useState(false);

  const [form, setForm] = useState({
    name: '',
    rate: '',
    appliesTo: 'Rent',
    status: 'active',
  });

  /* ---------------- HANDLERS ---------------- */
  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const persistTaxes = async (newTaxes) => {
    setTaxes(newTaxes);
    try {
      await api.post('/admin/settings', {
        tax_configuration: newTaxes // Controller handles JSON.stringify
      });
    } catch (e) { alert('Error saving taxes'); }
  };

  const handleSave = () => {
    if (!form.name || !form.rate) {
      alert('Please fill all required fields');
      return;
    }

    const newTaxes = [...taxes, form];
    persistTaxes(newTaxes);

    setForm({
      name: '',
      rate: '',
      appliesTo: 'Rent',
      status: 'active',
    });

    setShowModal(false);
  };

  /* ---------------- UI ---------------- */
  return (
    <MainLayout title="Tax Settings">
      <div className="flex flex-col gap-6">

        {/* SUMMARY CARDS */}
        <div className="grid grid-cols-[repeat(auto-fit,minmax(220px,1fr))] gap-5">
          <div className="bg-white p-5 rounded-xl shadow-[0_10px_25px_rgba(0,0,0,0.06)] animate-[fadeUp_0.6s_ease]">
            <h4 className="text-sm text-slate-500">Total Taxes</h4>
            <p className="text-xl font-bold mt-1.5 text-slate-900">{taxes.length}</p>
          </div>
          <div className="bg-white p-5 rounded-xl shadow-[0_10px_25px_rgba(0,0,0,0.06)] animate-[fadeUp_0.6s_ease]">
            <h4 className="text-sm text-slate-500">Active Taxes</h4>
            <p className="text-xl font-bold mt-1.5 text-green-600">{taxes.filter(t => t.status === 'active').length}</p>
          </div>
          <div className="bg-white p-5 rounded-xl shadow-[0_10px_25px_rgba(0,0,0,0.06)] animate-[fadeUp_0.6s_ease]">
            <h4 className="text-sm text-slate-500">Avg Tax Rate</h4>
            <p className="text-xl font-bold mt-1.5 text-slate-900">
              {(taxes.reduce((a, b) => a + Number(b.rate), 0) / taxes.length).toFixed(1)}%
            </p>
          </div>
        </div>

        {/* ADD BUTTON */}
        <div className="flex justify-end">
          <button className="bg-indigo-600 text-white border-none py-2.5 px-4 rounded-lg cursor-pointer transition-colors hover:bg-indigo-700 font-medium text-sm" onClick={() => setShowModal(true)}>
            + Add New Tax
          </button>
        </div>

        {/* TABLE */}
        <div className="bg-white rounded-xl overflow-hidden shadow-[0_10px_25px_rgba(0,0,0,0.06)]">
          <table className="w-full border-collapse">
            <thead>
              <tr>
                <th className="text-left p-3.5 bg-slate-50 text-[13px] text-slate-500 font-semibold border-b border-gray-100">Tax Name</th>
                <th className="text-left p-3.5 bg-slate-50 text-[13px] text-slate-500 font-semibold border-b border-gray-100">Rate (%)</th>
                <th className="text-left p-3.5 bg-slate-50 text-[13px] text-slate-500 font-semibold border-b border-gray-100">Applies To</th>
                <th className="text-left p-3.5 bg-slate-50 text-[13px] text-slate-500 font-semibold border-b border-gray-100">Status</th>
              </tr>
            </thead>
            <tbody>
              {taxes.map((tax, index) => (
                <tr key={index}>
                  <td className="p-3.5 border-t border-gray-100 text-sm text-slate-700">{tax.name}</td>
                  <td className="p-3.5 border-t border-gray-100 text-sm text-slate-700">{tax.rate}%</td>
                  <td className="p-3.5 border-t border-gray-100 text-sm text-slate-700">{tax.appliesTo}</td>
                  <td className="p-3.5 border-t border-gray-100">
                    <span className={`px-2.5 py-1 rounded-full text-xs font-semibold capitalize ${tax.status === 'active' ? 'bg-emerald-100 text-emerald-800' : 'bg-red-100 text-red-800'
                      }`}>
                      {tax.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* MODAL */}
        {showModal && (
          <div className="fixed inset-0 bg-black/45 flex items-center justify-center z-[999]">
            <div className="bg-white w-[420px] rounded-2xl p-6 animate-[zoomIn_0.3s_ease]">
              <h3 className="mb-4 text-base font-semibold text-slate-900">Add New Tax</h3>

              <div className="flex flex-col gap-3">
                <input
                  name="name"
                  placeholder="Tax Name"
                  value={form.name}
                  onChange={handleChange}
                  className="p-2.5 rounded-lg border border-slate-200 outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                />

                <input
                  name="rate"
                  type="number"
                  placeholder="Tax Rate (%)"
                  value={form.rate}
                  onChange={handleChange}
                  className="p-2.5 rounded-lg border border-slate-200 outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                />

                <select
                  name="appliesTo"
                  value={form.appliesTo}
                  onChange={handleChange}
                  className="p-2.5 rounded-lg border border-slate-200 outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 bg-white"
                >
                  <option>Rent</option>
                  <option>Maintenance</option>
                  <option>Utilities</option>
                </select>

                <select
                  name="status"
                  value={form.status}
                  onChange={handleChange}
                  className="p-2.5 rounded-lg border border-slate-200 outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 bg-white"
                >
                  <option value="active">Active</option>
                  <option value="inactive">Inactive</option>
                </select>
              </div>

              <div className="flex justify-end gap-2.5 mt-5">
                <button onClick={() => setShowModal(false)} className="py-2 px-3.5 rounded-lg border-none cursor-pointer bg-slate-100 text-slate-700 hover:bg-slate-200 text-sm font-medium">Cancel</button>
                <button className="py-2 px-3.5 rounded-lg border-none cursor-pointer bg-indigo-600 text-white hover:bg-indigo-700 text-sm font-medium" onClick={handleSave}>
                  Save Tax
                </button>
              </div>
            </div>
          </div>
        )}

      </div>
    </MainLayout>
  );
};
