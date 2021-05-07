import { Fragment } from "react"; 

import Link from "next/link";
import Head from "next/head";

import Markdown from "../../components/markdown/Markdown.js"

import { getPostsId, getPostData } from "../../lib/posts";

import styles from "../../styles/id.module.css";

import Layout from "../../components/Layout";
import Container from "../../components/Container";

export default function Post({ postData }) {
    return (
        <Fragment>
            <Head>
                <title>{postData.title}</title>
            </Head>
            <Layout>
                <Container
                    pageHeight
                >
                    <div className={styles.wrapper}>
                        <div
                            className={styles.postHeader}
                        >
                            <h2>{postData.title}</h2>
                            <h4>
                                The {" "} 
                                {new Date(postData.date).toLocaleDateString("fr-Fr")} { " "}
                                - By {postData.author} 
                            </h4>
                            <Link href="/">
                                <a>Go back to menu</a>
                            </Link>
                        </div>
                        <div className={styles.postBody}>
                            <Markdown
                                markdownData={postData.content}
                            />
                        </div>
                        <div className={styles.endLinks}>
                            <div>
                                {postData.previous && (
                                    <Fragment>
                                        <span
                                            className={styles.arrows}
                                        >
                                            {"<<"}
                                        </span>
                                        <Link 
                                            href={`/posts/${postData.previous}`}
                                        >
                                            {postData.previous}
                                        </Link>

                                    </Fragment>
                                )
                                }
                            </div>
                            <div style={{textAlign: "right"}}>
                                {postData.next && (
                                    <Fragment>
                                        <Link 
                                            href={`/posts/${postData.next}`}
                                        >
                                            {postData.next}
                                        </Link>
                                        <span
                                            className={styles.arrows}
                                        >
                                            {">>"}
                                        </span>
                                    </Fragment>
                                )
                                }
                            </div>
                        </div>
                    </div>
                </Container>
            </Layout>
        </Fragment>
    );
}

export async function getStaticPaths() {
    const paths = getPostsId();
    return {
        paths,
        fallback: false,
    }
}

export async function getStaticProps({ params }) {
    const postData = getPostData(params.id);
    return {
        props: {
            postData
        }
    };
}
