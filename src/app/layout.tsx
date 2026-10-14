import type { Metadata } from "next";
import { Suspense } from "react";
import { Geist, Geist_Mono } from "next/font/google";
import AuthProvider from "@/components/AuthProvider";
import CatalogProvider from "@/components/CatalogProvider";
import Header from "@/components/Header";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: { default: "Lógica Gamificada", template: "%s · Lógica Gamificada" },
  description:
    "Plataforma web gamificada para o ensino de lógica de programação.",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="pt-BR"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">
        <Suspense
          fallback={
            <p
              role="status"
              className="p-8 text-center text-zinc-500 dark:text-zinc-400"
            >
              Carregando...
            </p>
          }
        >
          <a
            href="#conteudo"
            className="sr-only focus:not-sr-only focus:absolute focus:left-2 focus:top-2 focus:z-50 focus:rounded-lg focus:bg-emerald-700 focus:px-4 focus:py-2 focus:text-white"
          >
            Pular para o conteúdo
          </a>
          <AuthProvider>
            <CatalogProvider>
              <Header />
              <main
                id="conteudo"
                tabIndex={-1}
                className="mx-auto w-full max-w-4xl flex-1 px-4 py-8 outline-none"
              >
                {children}
              </main>
            </CatalogProvider>
          </AuthProvider>
        </Suspense>
      </body>
    </html>
  );
}
