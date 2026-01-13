import React, { useState } from "react";
import { NavLink } from "react-router-dom";
import {
    LayoutDashboard,
    FileText,
    CreditCard,
    Files,
    ShieldCheck,
    Wrench,
    LogOut,
    X,
    CreditCard as PaymentIcon
} from "lucide-react";
import clsx from "clsx";

const TENANT_NAV_ITEMS = [
    { icon: LayoutDashboard, label: "Dashboard", path: "/tenant/dashboard" },
    { icon: FileText, label: "My Lease", path: "/tenant/lease" },
    { icon: PaymentIcon, label: "My Invoices", path: "/tenant/invoices" },
    { icon: CreditCard, label: "Pay Rent", path: "/tenant/payments" },
    { icon: Files, label: "My Documents", path: "/tenant/documents" },
    { icon: ShieldCheck, label: "Insurance", path: "/tenant/insurance" },
    { icon: Wrench, label: "Maintenance Tickets", path: "/tenant/tickets" },
];

export const TenantSidebar = ({ isOpen, onClose }) => {
    const handleLogout = () => {
        localStorage.removeItem("tenantLoggedIn");
        window.location.href = "/tenant/login";
    };

    return (
        <>
            <div
                className={clsx(
                    "fixed inset-0 bg-black/40 z-40 lg:hidden",
                    isOpen ? "block" : "hidden"
                )}
                onClick={onClose}
            />

            <aside className={clsx(
                "fixed left-0 top-0 h-screen w-[260px] bg-slate-50 border-r z-50 transition-transform",
                isOpen ? "translate-x-0" : "-translate-x-full",
                "lg:translate-x-0"
            )}>
                <div className="h-16 flex items-center px-6 justify-between">
                    <div className="flex items-center gap-2">
                        <div className="w-8 h-8 rounded-lg bg-primary-600 flex items-center justify-center text-white font-bold">T</div>
                        <span className="font-bold text-slate-800 text-lg">Tenant Portal</span>
                    </div>
                    <button className="lg:hidden" onClick={onClose}>
                        <X size={20} />
                    </button>
                </div>

                <nav className="px-4 py-4 space-y-1 flex flex-col h-[calc(100vh-64px)]">
                    <div className="flex-1 space-y-1">
                        {TENANT_NAV_ITEMS.map((item) => (
                            <NavLink
                                key={item.label}
                                to={item.path}
                                onClick={onClose}
                                className={({ isActive }) =>
                                    clsx(
                                        "flex items-center gap-3 px-4 py-3 rounded-md text-sm font-medium transition",
                                        isActive
                                            ? "bg-primary-50 text-primary-700"
                                            : "text-slate-600 hover:bg-slate-100"
                                    )
                                }
                            >
                                <item.icon size={20} />
                                <span>{item.label}</span>
                            </NavLink>
                        ))}
                    </div>

                    <button
                        onClick={handleLogout}
                        className="flex items-center gap-3 px-4 py-3 rounded-md text-sm font-medium text-slate-600 hover:bg-red-50 hover:text-red-600 transition mb-4"
                    >
                        <LogOut size={20} />
                        <span>Logout</span>
                    </button>
                </nav>
            </aside>
        </>
    );
};
