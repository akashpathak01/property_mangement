import React, { useState, useEffect } from "react";
import { NavLink, useLocation } from "react-router-dom";
import {
  LayoutDashboard,
  Building2,
  Users,
  FileText,
  Settings as SettingsIcon,
  PieChart,
  CreditCard,
  Calculator,
  ChevronDown,
  ChevronRight,
  X,
  Wrench,
  ShieldAlert,
  MessageSquare,
  ClipboardList
} from "lucide-react";
import clsx from "clsx";

/* =========================
   MENU CONFIG (FIXED)
 ========================= */

const NAV_ITEMS = [
  {
    icon: LayoutDashboard,
    label: "Dashboard",
    path: "/dashboard",
    children: [
      { label: "Overview", path: "/dashboard" },
      { label: "Vacancy Dashboard", path: "/vacancy" },
      { label: "Revenue Dashboard", path: "/revenue" }
    ]
  },
  {
    icon: Building2,
    label: "Properties",
    path: "/properties/buildings",
    children: [
      { label: "Buildings", path: "/properties/buildings" },
      { label: "Units", path: "/units" }
    ]
  },
  {
    icon: Users,
    label: "Tenants",
    path: "/tenants",
    children: [
      { label: "Tenant List", path: "/tenants" },
      { label: "Owners", path: "/owners" },
      { label: "Insurance Alerts", path: "/insurance-alerts" }
    ]
  },
  {
    icon: FileText,
    label: "Leases",
    path: "/leases"
  },
  {
    icon: CreditCard,
    label: "Payments",
    path: "/payments/invoices",
    children: [
      { label: "Rent Invoices", path: "/payments/invoices" },
      { label: "Payments Received", path: "/payments/received" },
      { label: "Outstanding Dues", path: "/payments/outstanding" },
      { label: "Refunds & Adjustments", path: "/payments/refunds" }
    ]
  },
  {
    icon: Calculator,
    label: "Accounting",
    path: "/accounting",
    children: [
      { label: "QuickBooks Sync", path: "/settings/quickbooks" },
      { label: "Chart of Accounts", path: "/accounting/chart-of-accounts" },
      { label: "Tax Settings", path: "/accounting/tax-settings" }
    ]
  },
  {
    icon: PieChart,
    label: "Reports",
    path: "/reports"
  },
  {
    icon: MessageSquare,
    label: "Communication",
    path: "/communication"
  },
  {
    icon: ClipboardList,
    label: "Maintenance",
    path: "/maintenance"
  },
  {
    icon: Wrench,
    label: "Tickets",
    path: "/tickets"
  },
  {
    icon: SettingsIcon,
    label: "Settings",
    path: "/settings"
  }
];

/* =========================
   NAV ITEM
 ========================= */

const NavItem = ({ item, depth = 0, onClose }) => {
  const location = useLocation();
  const hasChildren = item.children?.length > 0;
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    if (hasChildren) {
      const activeChild = item.children.some(child =>
        location.pathname.startsWith(child.path)
      );
      setIsOpen(activeChild);
    }
  }, [location.pathname]);

  const handleClick = (e) => {
    if (hasChildren) {
      e.preventDefault();
      setIsOpen(prev => !prev);
    } else {
      onClose?.();
    }
  };

  return (
    <>
      <NavLink
        to={item.path}
        onClick={handleClick}
        className={({ isActive }) =>
          clsx(
            "flex items-center gap-3 px-4 py-3 rounded-md text-sm font-medium transition",
            isActive && !hasChildren
              ? "bg-primary-50 text-primary-700"
              : "text-slate-600 hover:bg-slate-100"
          )
        }
        style={{ paddingLeft: `calc(16px + ${depth * 12}px)` }}
      >
        {item.icon && <item.icon size={20} />}
        <span className="flex-1">{item.label}</span>
        {hasChildren && (isOpen ? <ChevronDown size={14} /> : <ChevronRight size={14} />)}
      </NavLink>

      {hasChildren && isOpen && (
        <div className="ml-2">
          {item.children.map(child => (
            <NavItem
              key={child.path}
              item={child}
              depth={depth + 1}
              onClose={onClose}
            />
          ))}
        </div>
      )}
    </>
  );
};

/* =========================
   SIDEBAR
 ========================= */

export const Sidebar = ({ isOpen, onClose }) => {
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
          <div className="flex items-center">
            <img
              src="/assets/logo.png"
              alt="Masteko Logo"
              className="h-10 w-auto object-contain"
            />
          </div>
          <button className="lg:hidden" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <nav className="px-4 py-4 space-y-1">
          {NAV_ITEMS.map(item => (
            <NavItem key={item.label} item={item} onClose={onClose} />
          ))}
        </nav>
      </aside>
    </>
  );
};
