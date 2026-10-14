import Trail from "@/components/Trail";

export default function Home() {
  return (
    <>
      <h1 className="mb-1 text-2xl font-semibold">
        Trilha de Lógica de Programação
      </h1>
      <p className="mb-8 text-zinc-500 dark:text-zinc-400">
        Resolva os desafios em JavaScript, ganhe XP e conquiste medalhas.
      </p>
      <Trail />
    </>
  );
}
