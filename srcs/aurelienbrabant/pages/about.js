import Layout from "../components/Layout";
import Container from "../components/Container";

import styles from "../styles/about.module.css";

export default function About() {
	return (
		<Layout>
			<Container
				pageHeight
				size="md"
			>
				<div className={styles.wrapper}>
					<h1>About</h1>
					<img src="/blog/imgs/me.png" />
					<div className={styles.presentation}>
						<div>
							<h3>Hey !</h3>
							<p>
								I'm Aurelien, a french programmer and student at <a href="https://42.fr/">school 42</a>.
							</p>
							<p>
								I occasionally share useful content and personal thoughts on
								this awesome blog, so stay tuned!
							</p>
						</div>
						<div className={styles.contact}>
							<h3>Contact</h3>
							<h5>I'm pretty nice, don't worry :')</h5>
							<div>
								<a href="mailto:42@aurelienbrabant.fr">
									42 {" "}
									<span className={styles.actualEmail}>
										{" "}42@aurelienbrabant.fr
									</span>
								</a>
							</div>
							<div>
								<a href="mailto:aurelien@aurelienbrabant.fr">
									Pro {" "}
									<span className={styles.actualEmail}>
										aurelien@aurelienbrabant.fr
									</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</Container>
		</Layout>
);
}
