MIME-Version: 1.0
In-Reply-To: <1396603936-13045-1-git-send-email-mmarek@suse.cz>
References: <1396603936-13045-1-git-send-email-mmarek@suse.cz>
Date: Fri, 4 Apr 2014 06:47:26 -0300
Message-ID: <CAKi4VAKqM9sC26=qkWJ6Mw=u9YrbyBa4JGSN=pK5T8NZzQUSdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] testsuite: Do not run tests with *.ko.gz if zlib is
 not enabled
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Apr 4, 2014 at 6:32 AM, Michal Marek <mmarek@suse.cz> wrote:
> Unfortunately, all the depmod tests depend on zlib.

wouldn't it be better to decompress these files so we remove the dependencies?


> ---
>  testsuite/test-depmod.c   | 2 ++
>  testsuite/test-modprobe.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
> index b6023f1..86e89a4 100644
> --- a/testsuite/test-depmod.c
> +++ b/testsuite/test-depmod.c
> @@ -135,10 +135,12 @@ static DEFINE_TEST(depmod_search_order_same_prefix2,
>
>
>  static const struct test *tests[] = {
> +#ifdef ENABLE_ZLIB
>         &sdepmod_modules_order_for_compressed,
>         &sdepmod_search_order_simple,
>         &sdepmod_search_order_same_prefix,
>         &sdepmod_search_order_same_prefix2,
> +#endif

if you do this, then there will be no feedback if and why a test is
skipped.  Maybe defining some "global"  struct for skipped tests that
we call when a test must be skipped? Example:

#ifdef ENABLE_ZLIB
         &sdepmod_search_order_same_prefix2,
...
#else
        &sskip_due_missing_zlib,
...
#endif


const struct test sskip_due_missing_zlib = {
        .name = "skip_due_missing_zlib",
        .description = "test skipped due to missing zlib", /* Abusing
the description here to use in our test function */
        .func = skip_test,
};

static int skip_test(const struct test *t)
{
        printf("%s", t->description);
        return 0;
}

I don't really like the amount of ifdefs we can have... but maybe it
can be improved. What do you think?

-- 
Lucas De Marchi
