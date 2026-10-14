/**
 * Área com rolagem horizontal acessível: alcançável pelo teclado (Tab + setas), com nome para leitores de tela.
 * `relative` mantém dentro da área elementos posicionados de forma absoluta (como o texto "sr-only"),
 * que de outra forma escapariam e alargariam a página inteira no celular.
 */
export default function ScrollRegion({
  label,
  className = "",
  children,
}: {
  label: string;
  className?: string;
  children: React.ReactNode;
}) {
  return (
    <div
      role="region"
      aria-label={label}
      tabIndex={0}
      className={`relative overflow-x-auto outline-offset-2 ${className}`}
    >
      {children}
    </div>
  );
}
