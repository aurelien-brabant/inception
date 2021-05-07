import Link from "next/link";
import Socials from "./Socials";

import { useEffect, useState } from "react";

import styles from "../styles/header.module.css";

import { debounce } from "../lib/debounce";


export default function Header() {
	const [ prevScrollPos, setPrevScrollPos ] = useState(0);
	const [ visible, setVisible ] = useState(true);

	const handleScroll = debounce(() => {
		const currentScrollPos = window.pageYOffset;
		setVisible(
			(prevScrollPos > currentScrollPos && prevScrollPos - currentScrollPos > 70) 
			|| currentScrollPos < 10
		);
		setPrevScrollPos(currentScrollPos);
	}, 100);

	/* Event listener setup */
	useEffect(() => {
		window.addEventListener("scroll", handleScroll);	
		
		return () => window.removeEventListener("scroll", handleScroll);
	}, [ prevScrollPos, visible, handleScroll ]);

	return (
		<header
			className={
				`${styles.header} ${!visible ? styles.headerHidden : ""}`
			}
		>
			<div className={styles.headerBlock}>

				{ /* logo */ }
				<div className={styles.logoWrapper}>
					<i 
						className={`material-icons ${styles.logoIcon}`}>
						code
					</i>
					<div>
					<Link href="/">
						<a>
							<h1 className={styles.title}>
								Aurelien Brabant
							</h1>
							<h3 className={styles.subtitle}>
								Becoming a software engineer
							</h3>
						</a>
					</Link>
					</div>
				</div>

				<div className={styles.headerRight}>
					{/* naviguation bar */}
					<nav className={styles.navbar}>
						<ul>
							<li><Link href="/about"><a>About</a></Link></li>
						</ul>
					</nav>
					<Socials />
				</div>
			</div>
		</header>
	)
}
