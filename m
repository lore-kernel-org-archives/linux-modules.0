MIME-Version: 1.0
In-Reply-To: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
References: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
Date: Wed, 21 Jan 2015 10:17:05 -0200
Message-ID: <CAKi4VALAiP_j=J+5TjZ0ALt4zkXcUpyUozy2Wi6y9D70obn7+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] testsuite: add test for hash_add_unique
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 21, 2015 at 9:37 AM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> ---
>  testsuite/test-hash.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/testsuite/test-hash.c b/testsuite/test-hash.c
> index 3cf5ba7..ea39b80 100644
> --- a/testsuite/test-hash.c
> +++ b/testsuite/test-hash.c
> @@ -220,4 +220,30 @@ static int test_hash_free(const struct test *t)
>  DEFINE_TEST(test_hash_free,
>                 .description = "test hash_free calling free function for all values");
>
> +
> +static int test_hash_add_unique(const struct test *t)
> +{
> +       const char *k[] = { "k1", "k2", "k3", "k4", "k5" };
> +       const char *v[] = { "v1", "v2", "v3", "v4", "v5" };
> +       unsigned int i, j, N;
> +
> +       N = ARRAY_SIZE(k);
> +       for (i = 0; i < N; i++) {
> +               /* With 4 buckets, there'll be a bucket with more than one key. */
> +               struct hash *h = hash_new(4, NULL);

Applied with  's/4/N - 1/' here

-- 
Lucas De Marchi
