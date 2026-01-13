import React from 'react';
import clsx from 'clsx';

export const Button = ({
    children,
    variant = 'primary',
    size = 'md',
    className,
    icon: Icon,
    ...props
}) => {
    const baseStyles = "inline-flex items-center justify-center rounded-md font-sans font-medium cursor-pointer transition-all duration-150 border disabled:opacity-60 disabled:cursor-not-allowed disabled:bg-slate-100 disabled:text-slate-400 disabled:border-transparent gap-2 whitespace-nowrap select-none border-transparent active:translate-y-[1px]";

    const variants = {
        primary: "bg-primary-600 text-white shadow-sm hover:bg-primary-700 active:bg-primary-700",
        secondary: "bg-white border-slate-300 text-slate-700 shadow-sm hover:bg-slate-50 hover:border-slate-400 hover:text-slate-900 active:translate-y-0",
        outline: "bg-transparent border-primary-200 text-primary-600 hover:bg-primary-50 hover:border-primary-500 active:translate-y-0",
        ghost: "bg-transparent border-transparent text-slate-500 hover:bg-slate-100 hover:text-slate-900 shadow-none active:translate-y-0",
        danger: "bg-danger text-white hover:bg-[#dc2626]"
    };

    const sizes = {
        sm: "h-8 px-3 text-xs",
        md: "h-10 px-4 text-sm",
        lg: "h-12 px-6 text-base"
    };

    return (
        <button
            className={clsx(baseStyles, variants[variant], sizes[size], className)}
            {...props}
        >
            {Icon && <Icon size={18} className="flex items-center" />}
            {children}
        </button>
    );
};
