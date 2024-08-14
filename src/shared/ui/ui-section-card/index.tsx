import styles from './styles.module.pcss';

export function UiSectionCard({
  title,
  description,
  questionsCount
}: {
  title: string;
  description: string;
  questionsCount: number
}) {
  return (
    <div className={styles.sectionCard}>
      <h2>{title}</h2>

      <p>{description}</p>

      <div />

      <span>{questionsCount}</span>
    </div>
  )
}
