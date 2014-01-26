MIME-Version: 1.0
In-Reply-To: <20140126144607.07463138@heffalump.sk2.org>
References: <20140126144607.07463138@heffalump.sk2.org>
Date: Sun, 26 Jan 2014 18:05:58 -0200
Message-ID: <CAKi4VAJxLNdgm_VMuzdGQK8q2ZL2kORNzqYd0GOfWPV5cvUtLQ@mail.gmail.com>
Subject: Re: [PATCH] Remove "rmmod -w" documentation and getopt entry
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Stephen Kitt <steve@sk2.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Stephen,

On Sun, Jan 26, 2014 at 11:46 AM, Stephen Kitt <steve@sk2.org> wrote:
> Hi,
>
> The changelog for version 11 mentions that the "--wait" option on rmmod is no
> longer documented, but it still appears in rmmod.xml. In addition, the getopt
> handling in rmmod.c no longer supports "-w" or "--wait", but the cmdopts
> declaration still includes it.
>
> This patch removes the cmdopts declaration and the documentation.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
>
> diff --git a/man/rmmod.xml b/man/rmmod.xml
> index d9a6295..14c94dd 100644
> --- a/man/rmmod.xml
> +++ b/man/rmmod.xml
> @@ -39,7 +39,6 @@
>      <cmdsynopsis>
>        <command>rmmod</command>
>        <arg><option>-f</option></arg>
> -      <arg><option>-w</option></arg>
>        <arg><option>-s</option></arg>
>        <arg><option>-v</option></arg>
>        <arg><replaceable>modulename</replaceable></arg>
> @@ -94,22 +93,6 @@
>          </listitem>
>        </varlistentry>
>        <varlistentry>
> -        <term><option>-w</option> <option>--wait</option>
> -        </term>
> -        <listitem>
> -          <para>
> -            Normally, <command>rmmod</command> will refuse to unload modules
> -            which are in use.  With this option, <command>rmmod</command> will
> -            isolate the module, and wait until the module is no longer used.
> -            Nothing new will be able to use the module, but it's up to you to
> -            make sure the current users eventually finish with it.  See
> -            <citerefentry>
> -              <refentrytitle>lsmod</refentrytitle><manvolnum>8</manvolnum>
> -            </citerefentry>) for information on usage counts.
> -          </para>
> -        </listitem>
> -      </varlistentry>
> -      <varlistentry>
>          <term>
>            <option>-s</option>
>          </term>
> diff --git a/tools/rmmod.c b/tools/rmmod.c
> index fd0fac5..df2f041 100644
> --- a/tools/rmmod.c
> +++ b/tools/rmmod.c
> @@ -40,7 +40,6 @@ static const struct option cmdopts[] = {
>         {"syslog", no_argument, 0, 's'},
>         {"verbose", no_argument, 0, 'v'},
>         {"version", no_argument, 0, 'V'},
> -       {"wait", no_argument, 0, 'w'},
>         {"help", no_argument, 0, 'h'},
>         {NULL, 0, 0, 0}
>  };

I rebased this patch on git and applied. Note that we are already on
kmod 16... version 11 is old.


thanks

Lucas De Marchi
