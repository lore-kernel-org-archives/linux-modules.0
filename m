Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654409;
	b=F4nmEK7KP+grrddhSRB+CF7XQwGH81cg0wGUXLjBX8rLgX2wtr46swww3aeGDxc+C/Bw
	 /7cPdKqBw383p8xX03kFTuSik7Jc8P84DSShM2KxkDjQHuS2VDhHoTha2jdbjURutMu5K
	 lOfEyNikZJsf8Cs/lYg0e8dkvp5hUPjmoFu+b8oIl7DFTswbBOiNXFdnxb4pOIfQ/Z1wo
	 nxSAYIW2pv0CEi9Dm8bnDKdfIMuwbTpm/eK74OJ8HpJT+HqOuKR9yjqnhJi1oHmbMzZhQ
	 QJviqEn7ge1BG58J5iIK3rj1v2Xwa+vNkgjdR7I2xvMnoy2mhMEnyokYeotQx9KZSsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
	b=UpPVQNvYNUMMuTjHuKeUcz9T9iqnUyChBm53DOUcnQmSUbqPDexO1Uu7aP5DUDma+R8b
	 JZvdp7Ztb7sEVuIc7vt881YgiKsrgd+4J57QwWlhW0x2hfOE1R9BVxwKf3W7m5hBO5NeH
	 oIegN3QL8ZtjXmfLbb1DaBCndPbF1OE4Pyo+BlZWEYfOkDcNDZt7jUBSfpwDvsPCJlkb8
	 1OicXdIUw01/9Nw590MWka/GMC7a7wz5eAonPWIBiSvKFrtb/A3FEJTE6UNAiaXqcrI0Y
	 UfH3z61u3RWcAmMwSTTga295sD6b1dQq5MDTUHHb25q/mRjxjbFOr1yEtEXDXz9iVpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMbLOmTg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F741606A335
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 00:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F741606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMbLOmTg
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c5127c7abd5so1003665566b.3
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 16:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654408; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMvWV0iAANDjfAIWQFX8SbJ6O81DupXIQ2NQNjc+Ve0XgOD39yRbLYWecmn3ed27eD
         6OH2jvagkwQdtnaBWeDQREX7zOECsQbmIIWF2PPmPd9Pm6hQ5bthDGCGJdSxjynxuLgI
         SkejR0WoTiM/dc/uyoDx3vmW07r/M0J6iVR9teaPgyCewPooFtGR/gFSe4+LtkDkIlTO
         MK9ebMDv5PyKiGmHbNQl5sLnZi0Htu7KRFv45Q0J14NBt/9K+2XCcoYSL/E1iERfjSVw
         YH0lf6veQS4N2oPQYIxmXu3HnFiJgstBaaNNh5+v3Gzp6nfQmXOVkPSRdndhf/6JFgb4
         cqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        fh=BcBfyiR5M4zJzMQFuhZ0JM5XNbKNpomONvYa3zbarSA=;
        b=lukcN0WeIZflRHu+iApi3U4GjUuLdyjjwTpaVblxclgSXGJOeHyvp35IotydjrJxO3
         AfTLQTcKdTSsFbzoqh88cPTD0adtbXqjrzrk6wmdvDW1sirkoRjyAMD2rIma08hkG2Vj
         i7/mmnYhU0bcq60+PU+cXUCr2zXe5J/nTE/9HobG5g+073Vm8OcY2luEIl3SROoKpaX+
         iUGBJF69j0yf+ur789afJ8+gC7QXYgkHqzVq4qOOdSgS3xMpKuHQX+w6LxNXIDBv2Ntx
         FSgdm8qsCycK5PfeoBoHYRKEsmlXOSGTXXDYQ+Twv70zU+jvjIIXMGRZ1qJAaTSQJQY9
         F6Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654408; x=1796259208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        b=OMbLOmTgwkBLdVF5EdkYSC2XrgccLIkkqOXgyFgiuHmBsv8YiKTp9E0NEIyhirgYwo
         BZ+ApH53YZ2KTVkaJNbDjcMue9DCSXid0Du4+70qfpSn/U6BPQcaO0rTHvaEKiMrhjq+
         cgrO6KnCn2xh6qE6NyajQBDq/7N3cmFb2502QyBeGyuN0J8TZ8STFtPa+xPXpE5PEied
         9EIDboORco4TC6wv1vXi5MBxzHo/qEkcV1RPpsCU6P4rl7yl2ijcQhep5KTjor4bMPiQ
         FloIu+x3tOotka6vXyHSWrSW9RsgR8EkvzFkVBto/arghTtNsJHfG3gnYoPBAaEQS9BY
         49RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654408; x=1796259208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        b=a2Zq7JeKBYLAw8gJjX8oVoXuGcohcC/YOl3ftPlNvBRCIV/5ozuLCG7Z4ygUILwpDv
         7dNjHDOISljaZOnwUbabaxYntIlYh6jeKG0VykA3jdEV9EfL/pPNlu8HRvXsqbgtXIPV
         LZSwvyHDGXYuCb+r6ytDV+9JJZGFxZDOTuTplCTW7314adXSnslu3CpHGwBuPEQtYJ3S
         tD5o7RWn6J7fBcqVV8BlSHiqQ0CwV8DujC/70wZ4iJkJlKdQq+O8zFftlFyGdzwR4pFc
         /2gOfVtHd/fjTHfVENm51anF7lvnaSXYkk6C2jVrQbyll01Pm9XxKcFUUjWSFIyX/ru+
         23LA==
X-Forwarded-Encrypted: i=1; AL+hErFHFlz4Zl2D1+9oecVOAry6e9JhG9G5WzMcTNgDO7XgTr2Sgo+/ms8oNHEhU5CDNU4BEk0D5RGXmuladXNe@vger.kernel.org
X-Gm-Message-State: APuU4Z8mQIFnWspcnfpnzkj9riWEZuFf40QD+W1IiJQL8AZIpErqI1d2
	AZTpR1sNfCFSzYAP5aIvpjY7zWABr/Gm+wWUtVgSEGzUTOhQ1ez9eZzjX2GvILJBeqgcEB7xzJD
	EAWBvf9pDfcNLVjec32/JZ7dARMigur9gFDuT9OPW
X-Gm-Gg: AZFdTZeHFK9B4BHcu8ok1zUk1KoXBNMAk1uLNXEYEvNAVRYfzadUfKkkoBgPk85rcUx
	XRYIwQIagvB35/hdi3GbCZIOdpYnErgwA0nimtgnjImYxxCuSbvo5AFeydCvxDn3VC4bJGpzBk7
	4zdyXTeH9IDI2A5IqaqZwKOn3n3+2kPKpoXnuTjCSFDKcxHc6fCEvtdOd6UhMw8E/7mheDq7ItU
	Gwssia/GrRrham4Mel5xfrpPYVnjMk/skBQ9IAYO72PsvdYKadbId6/rhXEqyzaTqnyBzH+tsEe
	f6nONxtTyz5MNmEuFsCzRGiCOceBC+lxfLcnhdxWWrv8oKPY1l9oAVJvHWkGVzTk+m1sX6Dj7nq
	nwrDqu8ttTL4okb8FCvBn7jwe0m8lJFZBMXmmg2ilDrukSr9i/33hPZnGItXSdoDvJPw=
X-Received: by 2002:a17:907:c643:10b0:c2e:4292:d27e with SMTP id
 a640c23a62f3a-c513a816d3amr1138026566b.22.1795654407168; Wed, 25 Nov 2026
 16:53:27 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-19-wusamuel@google.com> <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
In-Reply-To: <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:53:16 -0800
X-Gm-Features: Aa3M54rfuKAHSB0QMI506grzDhwAStyJm9gAvy8QXVpNXfEJd-B8LId_HiOPEPc
Message-ID: <CAG2Kctq98pvyV=jmN0Di+p7m0AWQKg8+QF5YBvdLi79kTJaKoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/9] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY_BY_NAME ioctl
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Wed, Nov 25, 2026 at 12:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > libbpf parses all of /proc/kallsyms to resolve typeless ksyms.
> >
> > Use KALLSYMS_QUERY_BY_NAME instead: exact names, plus "<name>.llvm."
> > prefix matches. Ambiguous matches at different addresses fail the load.
> > A missing strong extern still fails and a missing weak extern is 0,
> > without a text scan.
> >
> > On any other error (e.g. -ENOTTY on older kernels, or -EPERM), fall bac=
k
> > to the text parser.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 44134421bd7d..f3f3475a64d3 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -59,6 +59,34 @@
> >  #define BPF_FS_MAGIC           0xcafe4a11
> >  #endif
> >
> > +#ifndef KALLSYMS_QUERY_BY_NAME
> > +/* 'f' is PROCFS_IOCTL_MAGIC */
> > +#define KALLSYMS_QUERY_BY_NAME _IOC(_IOC_READ | _IOC_WRITE, 'f', 48, 0=
)
> > +
> > +enum kallsyms_query_flags {
> > +       KALLSYMS_QUERY_NAME_PREFIX =3D 0x01,
> > +};
> > +
> > +struct kallsyms_query_sym {
> > +       __u64 sym_addr;
> > +       __u64 sym_size;
> > +       __u64 sym_name;
> > +       __u64 sym_name_len;
> > +       __u64 sym_module;
> > +       __u64 sym_module_len;
> > +};
> > +
> > +struct kallsyms_query_by_name {
> > +       __u64 size;
> > +       __u64 query_flags;
> > +       __u64 query_name;
> > +       __u64 module_filter;
> > +       __u64 pos;
> > +       __u64 sym;
> > +       __u64 sym_struct_size;
> > +};
> > +#endif
> > +
>
> there is no need for this, libbpf in kernel can use kernels' most up
> to date UAPI headers directly, and on Github we sync necessary UAPI
> headers into include/ directory, so libbpf source code can be built
> with latest definitions of kernel UAPI. So you can drop this part

Ack, will drop entire #ifndef block
[...]

> > +
> > +       while (!ioctl(fd, KALLSYMS_QUERY_BY_NAME, &q)) {
> > +               if (!ext->is_set) {
> > +                       ext->is_set =3D true;
> > +                       ext->ksym.addr =3D sym.sym_addr;
> > +                       pr_debug("extern (ksym) '%s': set to 0x%llx\n",
> > +                                ext->name, ext->ksym.addr);
> > +               } else if (sym.sym_addr !=3D ext->ksym.addr) {
> > +                       pr_warn("extern (ksym) '%s': resolution is ambi=
guous: 0x%llx or 0x%llx\n",
> > +                               ext->name, ext->ksym.addr,
> > +                               (unsigned long long)sym.sym_addr);
> > +                       return -EADDRNOTAVAIL;
>
> I think there is ENOTUNIQ which we can utilize here

Ack
[...]

> > +               /* Check exact name and then LTO .llvm.<hash> prefix */
> > +               err =3D query_ksym_by_name(fd, ext, false);
> > +               if (!err)
> > +                       err =3D query_ksym_by_name(fd, ext, true);
>
> err =3D err ?: query_ksym_by_name(fd, ext, true /* lto_prefix */);

Ack- will update in v4. Thanks for the thoughtful review!
