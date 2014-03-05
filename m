MIME-Version: 1.0
In-Reply-To: <1393948285-16254-1-git-send-email-mmarek@suse.cz>
References: <1393948285-16254-1-git-send-email-mmarek@suse.cz>
Date: Wed, 5 Mar 2014 12:26:35 -0300
Message-ID: <CAKi4VA+AFGGEKXgibJFkk7n31A=gr7qTm_4H1jTMmHfS6RZfMg@mail.gmail.com>
Subject: Re: [PATCH] libkmod-config,depmod: Accept special files as
 configuration files, too
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Tue, Mar 4, 2014 at 12:51 PM, Michal Marek <mmarek@suse.cz> wrote:
> If we can open it and read it, it's good enough for us. Otherwise, we
> cannot use -C /dev/null to skip the system configuration for instance:
>
> $ ./tools/modprobe -C /dev/null -c
> libkmod: ERROR libkmod/libkmod-config.c:821 conf_files_list: unsupported
> file mode /dev/null: 0x21b6
> ...
> ---

Applied, thanks.

Lucas De Marchi
