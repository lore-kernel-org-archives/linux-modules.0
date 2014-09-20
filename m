MIME-Version: 1.0
In-Reply-To: <20140917031328.003016619@bongo.bofh.it>
References: <20140917031225.559902121@bongo.bofh.it>
	<20140917031328.003016619@bongo.bofh.it>
Date: Sat, 20 Sep 2014 11:21:33 -0300
Message-ID: <CAKi4VA+E5KskC9pHiQaLvOAASkQC-x+ThnLrJOrB-z=G2X0wSQ@mail.gmail.com>
Subject: Re: [patch 1/2] Document depmod --show in depmod(8)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: "Marco d'Itri" <md@linux.it>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Sep 17, 2014 at 12:12 AM, Marco d'Itri <md@linux.it> wrote:
> --- a/man/depmod.xml
> +++ b/man/depmod.xml
> @@ -236,6 +236,9 @@
>            <option>-n</option>
>          </term>
>          <term>
> +          <option>--show</option>
> +        </term>
> +        <term>
>            <option>--dry-run</option>
>          </term>
>          <listitem>
>
>
> --

Applied.

-- 

Lucas De Marchi
