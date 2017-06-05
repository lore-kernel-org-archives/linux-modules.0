MIME-Version: 1.0
In-Reply-To: <1496502202-9832-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496502202-9832-1-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Mon, 5 Jun 2017 01:04:46 -0700
Message-ID: <CAKi4VA+3azA-8pyNS0F73d_0ahCA7=n_opwnxp9A-2Y67oLe8w@mail.gmail.com>
Subject: Re: [PATCH kmod] shared/util.c: assert_cc() can only be used inside functions
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Sat, Jun 3, 2017 at 8:03 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> shared/macro.h has two versions of assert_cc, one that uses gcc
> _Static_assert(), which requires recent enough gcc versions, and one
> that uses a fake array to trigger a build error. The latter can only
> work inside functions, so assert_cc() should only be used inside
> functions.
>
> Fixes the following build failure when building kmod with old gcc
> versions such as gcc 4.3.x:
>
> shared/util.c:52: error: expected identifier or '(' before 'do'
> shared/util.c:52: error: expected identifier or '(' before 'while'
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

The changes look simple, but going forward I'd like to understand
this. kmod requires C11 that contains _Static_assert().

Is there a compelling reason to support a compiler that old? GCC 4.3.0
has been released 9 years ago.

Lucas De Marchi
