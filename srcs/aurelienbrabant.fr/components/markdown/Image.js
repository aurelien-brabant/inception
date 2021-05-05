
import styles from "../../styles/markdown/image.module.css";

export default function Image({ src, alt }) {
	return (
		<a
			href={src}
			target="_blank"
		>
			<img
				className={styles.img}
				src={src}
				alt={alt}
			>
			</img>
		</a>
	)
}
