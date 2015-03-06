MIME-Version: 1.0
In-Reply-To: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
References: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
Date: Fri, 6 Mar 2015 00:24:08 -0300
Message-ID: <CAKi4VAKHZEybgR=cz5P1Zc8VrhE-1VuyqM1j+FpyZEnbVgrPnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] testsuite: remove .gitignore files when populating rootfs
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 5, 2015 at 1:06 PM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> Usually this file is added to keep a directory existing in the
> repository but without any real content. In rootfs this can be
> problematic if a directory will have all its files inspected. This
> happens for kmod_module_get_holders().
>
> Side-note: the 'test-loaded.c' is hit by this problem but doesn't
> "notice" because the invalid module returned by get_holders() is not
> checked. The modules in its loop are only used to get the name and
> generate an output, and NULL was a valid value to generate the name.
> ---

applied this and the second patch... some comments on the third one.


-- 
Lucas De Marchi
