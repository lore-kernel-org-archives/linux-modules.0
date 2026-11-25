Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638319;
	b=zs/Z+A2Qy1wj7Uj5H0MPpYkYnBdFUiq0YCQ3N8o/FQz9wptpL+HJI/X49laX1wBI3lWk
	 osTbRvNz8mEx3kdOXrrX2nfFrYAJibpKQmSpUkMiB+i+b92cygJbfrBPzB7419vx+DOKs
	 CCXLzVzKtdCfYG3nDxPhOOu9UXOWj+XYYZJQY+T2kpjtRDUqEx28vwcnDDuORyWyacof1
	 cYsEGr9mgnNqbbs7Mvmx5q22LjJVwL4I6NzXNTRTE0rssO38MZygtwfMrYeycAtXSvxB5
	 DrSVCpSmEjPwSLUHCEXs38ILxpM5qsFSyJrpuKSrGVFR1+r7ocb4EOrVxAU+VgqLj7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p9IirqDfAOTVejDkPFAqBuLyzIAHl90Deo3aTCgyC9U=;
	b=GddjBi51QgZV95OxAeEd89rVSDDdzVnOPcczqj2XRf1v6phFNvZeNYkDCvpdgLq5ugMl
	 Y4D9XpGqX+WiEXSL/eFdJbvBoBiIGH5G6Pj+S953EptBo07vaBhCJEZHyqO2bZAb5uanm
	 6zYpCnjsy9u8ijbP7WwaSOUlYEGih20+2GrzchC5//m1YkCbK/OhnZJQg/CxrVfe8CtPo
	 yftpmZyq/zldtZp/hIGzWxqmZgyKwcfMplO4RNtfWfdkk4eZ29QM5nc/t0GH3vQRrXlAM
	 nHiaFubdVZr3cWIGndc7B9hf0tePDsnLgnqpk+vmgiR6hpav9cylo+qx7U4zzPQ9J4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6lQClQE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E9606A693
	for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 20:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78E9606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6lQClQE
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so53863185e9.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 12:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638317; cv=none;
        d=google.com; s=arc-20260327;
        b=V6rN2SbbB2RAkG9tCyKWKRi8ck1nlL7moyMKobpGLQf2Wt9JBFOZfCrnFwvVbAZGld
         B7mc9C0fydLCGo0gpFabZCWTo+83pJqlz9FSH77Kj2OqEH3Ix3hRVfCYv35Dl0mAp3Gy
         MkF9EkNxdzhWDxCK816aHYtioq6BLHhqJsBQLYXK403B0/SsRyeXOxq3wYcTZvF102JX
         lIwJdqbvEUJ+9UqeoHf1VWdrLVVlEWC72bVRmQREIC0kx1B4d9ygVC44BanLEyx6gcpI
         svLtuwC5mueGRfgoMkvkC6VEQngBW0IHibgeOi41kWXh4fPi8iujiejow3mTnMTPMM2i
         YDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p9IirqDfAOTVejDkPFAqBuLyzIAHl90Deo3aTCgyC9U=;
        fh=0Y0T6d3hrmFregZxw3KLayyq2HbDIm0/+gyXp+/XeRs=;
        b=PlrYlkUqjbXxmnzBwixSJ1qzgnffwHq+H1QHQQS1Da4tsdKvS72TUHIl2B82kfiYyq
         oC6w9dWjBRTQ4vYkWxasm+AYfdhCX3bI5VxE+wprmj1J+Db6wMUO1iFz8165YkhuruUq
         wv3d0lhMJGeEjTYcayf/4jzEaiEkZA1LlRtFDyJ3UUtZoCaL0OfNyOU7Wa9i5VKZaDfS
         taGjxI0EXz+ZjXthROPHkSaOlonLP6jyQ37dTbEIrib1NVM+ShJbqzvK/FQALRyPhJzx
         v/gllOKh8/+C8UIgNTYrFMkAiKDNY5tK0N4y6j2HB9x27N3iNgFDoITG3IyYJmc8UqYK
         ZAaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638317; x=1796243117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p9IirqDfAOTVejDkPFAqBuLyzIAHl90Deo3aTCgyC9U=;
        b=U6lQClQEkTfT/Djs6sxofcxEM+1ml78AKaQozxaTTbHBld31wCjeZ2RWZbrNS7NRIm
         MRtvIXLwQox846me22/6GlRPwDV06kCtFh12S0htXSTxnJDCTM5wBACvb8ZU7Mye6B5N
         3xW7jni7Gle/6Z3mNK0KjkwmcVXDycy36TdUpsvq0nD/tmVcAzXVKlxD4ciOeaJV/lyT
         L+A7FZrhPQm7shYbMWBBLV8jvZWcAd1JXYbOLIbH3cBGuf3uKOhzNvI8x7MsQlNQQ3od
         iNEkO1c2d2SW0CgwDHlO5Z1ahmQU4Mjd38x6pYdmKMZmX8KzB/xm6IEnAM+C3PHxtYTo
         QSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638317; x=1796243117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9IirqDfAOTVejDkPFAqBuLyzIAHl90Deo3aTCgyC9U=;
        b=Br1maZL6I/+jFT4qtSkxV3xan01+iONkufgWInaHMLn6NVoAr+Mrp5bUGTmuOdJw2+
         UqPfrLbPChEbEVbDMrfZWGrJTVfoF5ouUD6M0E77x7jZhlhoZKQ7iyhGwUeZamR3X0h/
         pBsNigQC+OkrkwpAlMlrcyhEHJ/lnNOvpLMlrzdRJZywDErJKrFHLmdncLfRzdHQrVT9
         yrYXom/V2uc1WHJKZF3SlAcnTBpjGCcpsN20u9NgFJSXIfMcx8B8Jvr+z60yViUM3Ytq
         7dUDQQVponTquZzyZ5V37yyqMaC9TQfwmSRGAe9xW/oHaEaUJdovx02gcoScsPMinFqP
         492g==
X-Forwarded-Encrypted: i=1; AL+hErGC/TVpyLt5sDpVLTDRuJd9lO/1697vHgPRfXHmsk+06yLqJBA9n1K71hZXAs0ZIORRtDq8hJzDxwko+Z57@vger.kernel.org
X-Gm-Message-State: APuU4Z+3vw6IcgqDP9ajs030sN6IEJzfr2+kEi/pCjqvgvSZGFCBMPCp
	YyBQ11AykuqUylSzPXhL4qAPb6CChefK2T888HXducEuDNntUVzjUQtjgLxUJBAWQrxhzTwk6eS
	iv+WgZgqtbCrn1VQWgI5T6gUHtTCuvL8=
X-Gm-Gg: AZFdTZc8E82Idyv5WL8NpCoc9BaRJqvwZ818CwkTFSm0cFCZ+l2KEGrslvmTIK6mOXp
	+6Uv6CgKUUBQMK68OBlXuEnYnCzjBGCBq+kz2Yj4PkzAcOQhOp/Khbg0zF2FlI6Lrzfe0GZxqWf
	4JjxnZ1khKFDuCohc3FMxBELSfhRvTbPf9kwgHHWq1IXAUX7e1vS4lYmy+VdEtsnki8EGvrHsEK
	JLDgzEaEr0D97utnad7sgIKbNIaBvIMGz0iiqjzQa5qKpvR9wMWF/aiVWbahQkLbip/0nGPniiV
	PWvswpLT17D3W73xyUGlmHZAllcgQQK87LdKmziyX1YJpPdQdzBHIE01+kxlJPoDolrhZ7j4wu3
	VH/p4i6rQL3mP09RNcbm+V8bMkd1B1QE1ggiYnVHL1ml9Po094SESQewwfOvkHRcafG3YxSK4DF
	+4PEMBKzgIMgL9FnsrriA=
X-Received: by 2002:a05:600c:1389:b0:4af:83ad:8f70 with SMTP id
 5b1f17b1804b1-4bb88924f66mr382908465e9.35.1795638317113; Wed, 25 Nov 2026
 12:25:17 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261113221248.3535369-15-wusamuel@google.com>
In-Reply-To: <20261113221248.3535369-15-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:25:05 -0800
X-Gm-Features: Aa3M54o-lsDlv9tHK0FdKSsemQf2iUiz2mvyNbuvwkHzJEpFwnOT1T_ooxy3Pro
Message-ID: <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] kallsyms: Add KALLSYMS_QUERY_BY_ADDR
 ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> Symbolizers such as Perfetto read all of /proc/kallsyms and keep a
> sorted copy in memory to resolve addresses.
>
> Add the KALLSYMS_QUERY_BY_ADDR ioctl. It returns the symbol that covers
> an address, from the same sources and in the same order as %pS. BPF JIT
> symbols are hidden when /proc/kallsyms hides them. query_flags must be
> 0; it is reserved for other modes.
>
> The command uses 'f' 0x31; register 0x31 in ioctl-number.rst.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  2 +-
>  include/uapi/linux/fs.h                       | 13 ++++
>  kernel/kallsyms.c                             | 60 +++++++++++++++++++
>  3 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index f5dbb597257a..d9b66e7a29b7 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -250,7 +250,7 @@ Code  Seq#    Include File                           =
                  Comments
>  'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       c=
onflict!
>  'f'   10-11  linux/fs.h                                                c=
onflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
>  'f'   13-27  linux/fscrypt.h
> -'f'   30     linux/fs.h                                                p=
rocfs kallsyms ioctls (PROCFS_IOCTL_MAGIC)
> +'f'   30-31  linux/fs.h                                                p=
rocfs kallsyms ioctls (PROCFS_IOCTL_MAGIC)
>  'f'   81-8F  linux/fsverity.h
>  'g'   00-0F  linux/usb/gadgetfs.h
>  'g'   20-2F  linux/usb/g_printer.h
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 987569dcdbea..c1a63c8560e2 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -676,6 +676,7 @@ struct procmap_query {
>
>  /* /proc/kallsyms ioctls. -EPERM if the opener cannot see kernel address=
es. */
>  #define KALLSYMS_QUERY_BY_NAME _IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL=
_MAGIC, 48, 0)
> +#define KALLSYMS_QUERY_BY_ADDR _IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL=
_MAGIC, 49, 0)
>
>  enum kallsyms_query_flags {
>         /* Match query_name as a prefix. */
> @@ -717,6 +718,18 @@ struct kallsyms_query_by_name {
>         __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym)=
 */
>  };
>
> +/*
> + * Find the /proc/kallsyms entry that covers query_addr, or return -ENOE=
NT.
> + * ftrace trampolines and kprobe pages are not resolved yet.
> + */
> +struct kallsyms_query_by_addr {
> +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_a=
ddr) */
> +       __u64 query_flags;      /* in - must be 0 */
> +       __u64 query_addr;       /* in - kernel address */
> +       __u64 sym;              /* in - user ptr to struct kallsyms_query=
_sym */
> +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym)=
 */

nit: same as in previous patch, I'd keep "sym_size". But hey,
"sym_len" is even better and follow same naming as with sym's
name/module, no?


> +};
> +
>  /*
>   * Shutdown the filesystem.
>   */
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 29a9da04d8a3..6d7032cd3fd6 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -1223,6 +1223,64 @@ static int do_kallsyms_query_by_name(struct kallsy=
ms_query_by_name __user *uarg)
>                                          &bufs->m);
>  }
>
> +/*
> + * Look up symbol from addr. Copy the module name under RCU, and hide BP=
F JIT
> + * symbols as /proc/kallsyms hides them.
> + */
> +static int kallsyms_find_addr(unsigned long addr, struct kallsyms_sym_ma=
tch *m)
> +{
> +       unsigned long offset;
> +       char *modname;
> +
> +       guard(rcu)();
> +       if (!kallsyms_lookup_buildid(addr, &m->size, &offset, &modname, N=
ULL,
> +                                    m->name))
> +               return -ENOENT;
> +
> +       /* Outside vmlinux, only BPF JIT symbols have no module name. */
> +       if (!modname && !is_ksym_addr(addr)) {
> +               if (!bpf_jit_kallsyms_enabled())
> +                       return -ENOENT;
> +               modname =3D "bpf";
> +       }
> +
> +       m->addr =3D addr - offset;
> +       strscpy(m->modname, modname ?: "", MODULE_NAME_LEN);
> +       return 0;
> +}
> +
> +static int do_kallsyms_query_by_addr(struct kallsyms_query_by_addr __use=
r *uarg)
> +{
> +       struct kallsyms_query_by_addr karg;
> +       struct kallsyms_query_sym ksym;
> +       struct kallsyms_sym_match m;
> +       int err;
> +
> +       err =3D kallsyms_copy_query_from_user(&karg, sizeof(karg),
> +                                           offsetofend(struct kallsyms_q=
uery_by_addr,
> +                                                       sym_struct_size),
> +                                           uarg);
> +       if (err)
> +               return err;
> +
> +       if (karg.query_flags)
> +               return -EINVAL;
> +
> +       err =3D kallsyms_copy_sym_from_user(&ksym, karg.sym, karg.sym_str=
uct_size);
> +       if (err)
> +               return err;
> +
> +       if (karg.query_addr > ULONG_MAX)
> +               return -ENOENT;
> +
> +       err =3D kallsyms_find_addr(karg.query_addr, &m);
> +       if (err)
> +               return err;
> +
> +       return kallsyms_copy_sym_to_user(karg.sym, karg.sym_struct_size, =
&ksym,
> +                                        &m);

nit: if it fits under 100 characters, please try to keep code in
single-line form as much as possible


> +}
> +
>  static long kallsyms_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
>  {
>         struct seq_file *m =3D file->private_data;
> @@ -1232,6 +1290,8 @@ static long kallsyms_ioctl(struct file *file, unsig=
ned int cmd, unsigned long ar
>         switch (cmd) {
>         case KALLSYMS_QUERY_BY_NAME:
>                 return iter->show_value ? do_kallsyms_query_by_name(uarg)=
 : -EPERM;
> +       case KALLSYMS_QUERY_BY_ADDR:
> +               return iter->show_value ? do_kallsyms_query_by_addr(uarg)=
 : -EPERM;
>         default:
>                 return -ENOIOCTLCMD;
>         }
> --
> 2.56.0.679.gc527c65306-goog
>
