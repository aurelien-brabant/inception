import styles from "../../styles/markdown/inlinecode.module.css";

export default function InlineCode({ value }) {
	return (
		<span
			className={styles.inlineCode}
		>
			{value}
		</span>
	)
}
