MIME-Version: 1.0
In-Reply-To: <1478638646-5933-1-git-send-email-yauheni.kaliuta@redhat.com>
References: <1478638646-5933-1-git-send-email-yauheni.kaliuta@redhat.com>
Date: Tue, 8 Nov 2016 22:24:08 -0200
Message-ID: <CAKi4VAKtjHtK0HfRJz6T6S5HWz8Td3dXtR7++JzFfCYA_+iJig@mail.gmail.com>
Subject: Re: [PATCH] testsuite: fix test_array_sort pointers inderection
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>, Jessica Yu <jeyu@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Nov 8, 2016 at 6:57 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> The array elements in the tests are strings, what means "char *"
> in =D0=A1. The comparation funtion takes pointers to the elements, so
> the arguments become "char **". It means, that strcmp() cannot be
> used directrly.
>
> The patch creates a wrapper on strcmp() which perfoms
> dereferencing of the "char **" to supply the actual strings to
> strcmp(), and uses the wrapper as a comparation function for the
> qsort() call.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Applied, thanks.


Lucas De Marchi
