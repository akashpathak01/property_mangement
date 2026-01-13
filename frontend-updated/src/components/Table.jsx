import React from 'react';

export const Table = ({ columns = [], data = [] }) => {
  // 🛡 SAFETY GUARD
  if (!columns.length) {
    return <div className="p-8 text-center text-slate-400 text-sm">No columns defined</div>;
  }

  return (
    <div className="w-full overflow-x-auto bg-white rounded-lg border border-slate-200 shadow-sm mb-4">
      <table className="w-full border-collapse text-left transition-all">
        <thead>
          <tr>
            {columns.map((col) => (
              <th
                key={col.key}
                className="px-6 py-3 bg-slate-50 border-b border-slate-200 text-slate-500 font-semibold text-xs uppercase tracking-wider whitespace-nowrap h-12"
              >
                {col.label}
              </th>
            ))}
          </tr>
        </thead>

        <tbody>
          {data.length === 0 ? (
            <tr>
              <td colSpan={columns.length} className="p-8 text-center text-slate-400 text-sm">
                No data available
              </td>
            </tr>
          ) : (
            data.map((row, idx) => (
              <tr key={idx} className="hover:bg-slate-50 transition-colors duration-150">
                {columns.map((col) => (
                  <td
                    key={col.key}
                    className="px-6 py-4 border-b border-slate-100 text-sm text-slate-900 align-middle h-14"
                  >
                    {row[col.key]}
                  </td>
                ))}
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
};
