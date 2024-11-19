Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630DB195F28
	for <linux-modules@vger.kernel.org>; Tue, 19 Nov 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732052296; cv=none; b=EbQYdIX+oHRYSeWclIHulhsrse4Fz1nQX4x8kyzzxqgvNn5x23OVYMlQfg0J4ffRH8CE5F4mq17vLT6k2396ffGXYW7w0tAuGRJxu2GhKxDNAKVa/N1kcxRL9sbPaDX37EZMEXGNBcyjK9BU37UbgHmeRGNhltMPU6uCb0SiArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732052296; c=relaxed/simple;
	bh=Zd2QB6z5/nO/5q32zOMmJULah0pVbTKjUr9QlGKD+V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCNEw212/5jqy4cxSDMpzhgvgvOoVj8cz21tNFai1JWEMUWrtturruIw3E00BlSefPMHsoF6yDj5juoGjMrNkSgmSZD8+Ansci2oIPIsHYrzPqvMKSDr3hAHP4SU7dMPtH4TDaWle/AdhnuJDK/0PuWIeD0EyVDiDu+YI6f52FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riOe9kTP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riOe9kTP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so16972a12.0
        for <linux-modules@vger.kernel.org>; Tue, 19 Nov 2024 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732052293; x=1732657093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHaLTJLv2qMAaXUVhzeSonG7VLA1CIIMmtCZ7ax6TDw=;
        b=riOe9kTPt2Z4CGEcbASPouoXwaiHTuSrqylopYOwFm2ooik3fCWEN5wQ7CFc4BpHi1
         Z09pMsnCRkkEtbwCNA309i5p3KGGGAAPvse4M5K6q8EC8W1Prq6kyI12w0J/ruevidYC
         lJTWrfCwgZu/Vo8WjsutqlgwruYRy3MFheM1PCrWzoAHiBcsG//++wjvnf/U4QRdPMTr
         1RjAlbdldv64NIOOrSdf1eOu3jMnYQQSbdWPIVo1x95LEWAeIiel/z8cIBaPrXtY66wz
         iaKmmmsINe2jLKDJGhpqkTbFfkGe5EHL5MHcMmwNBbD6x7xNSXJbWMbJEA6qS1Ml6uet
         CneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732052293; x=1732657093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHaLTJLv2qMAaXUVhzeSonG7VLA1CIIMmtCZ7ax6TDw=;
        b=vBaxbomesW7CzYiSxNfKhVui5BOavNmoX8DDUc1sLIKplvOMbW3BKKO983AMIJCd0r
         KqVTJ+6yeCYNYKOUvPrjDywAl8aVpUPOVpp7NA/lHItgP0nj9opRO/RycOqDUyoftRzU
         ZOiW6ahD7x3hKEEh4TDIUElpYFgsjBG1Feu5/jkQM+8i6gDm3Gce1B/PHgpQOXeE9D+2
         MtqZOLwMB95jsVx8vN2tw9vz1V6luxqDTjBawroVpeG5Akty31CjROF8/5LZXsiN/xmS
         NUs8klDVl4uv5zbUJAfryeWceWLBAliw1BnXDL43IQ0eCS9I444Ee6i+VlRTS9qgkoyP
         eBDw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8asJRfDHnBg0sGCVpure0YeTqBF8DexwQLOfvfu171X2jdMhiJIz21XUmH5ytjNyLFqYj6lQ1anLDvAw@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNOuwEtmahqkl8etLqFqL3CSou6Zj6jNM9CQ2fWjKIYkeB+Tq
	ncH3MMYAs7nycxmOerbEJJmFQWZVEpdOhu8/Y0T/xdzgCryJNoDUeEAUyFtJw9NkiqT4sgzp8BZ
	JYDNG9erWZIXS2vFWrByTufZWRrqSIC4Bve5L
X-Gm-Gg: ASbGncsa8JrznGueUZ4ikgtJz4XTdsj3rS9OuiIK9NOix2OKAJSQKfAZ6dxrs+Uh+0r
	Xsr3lxGvwScm6s8f+1yihvGaqKjcDx041Tu8/0TwMUhjA3VekQmq767zD7+nxEA==
X-Google-Smtp-Source: AGHT+IEu1TvsuhTaj4Y+Akxvvr6wi40qDULQBNFY0mTnIT/+3AaCJ0gDLLAcrNpIwNcwmpaw1b+off/DTHI6qwyqUP8=
X-Received: by 2002:a05:6402:b3a:b0:5cf:f20c:bdf0 with SMTP id
 4fb4d7f45d1cf-5cff4314190mr20664a12.4.1732052292462; Tue, 19 Nov 2024
 13:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com>
 <20241030170106.1501763-22-samitolvanen@google.com> <CAK7LNAShVzrE6uhXxZ7HepKhmOJYsZeigq6w19jRN3OH-T_Jyg@mail.gmail.com>
 <CABCJKueVjP8V-=3Ehi4QvQzg1FZh2unyVMDzSJ_vJ_E5EE+gLg@mail.gmail.com>
 <CAK7LNARVK1ZpGXZVTAynuo7CDjgB4uT5bQzcGiWseZfaEu7Tvw@mail.gmail.com>
 <CABCJKufVpx4dsr7A44qA0ydwTEx+3Qy_OMx9Ch6OKa4nzvRj2g@mail.gmail.com> <20241119204829.GA1926309@frogsfrogsfrogs>
In-Reply-To: <20241119204829.GA1926309@frogsfrogsfrogs>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 19 Nov 2024 13:37:35 -0800
Message-ID: <CABCJKue+n2V5vua2=Hwc1SXBdkmdLBD7ac8imt5HO1bsy7s9dw@mail.gmail.com>
Subject: Re: [PATCH v5 01/19] scripts: move genksyms crc32 implementation to a
 common include
To: "Darrick J. Wong" <djwong@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, Sedat Dilek <sedat.dilek@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Darrick,

On Tue, Nov 19, 2024 at 12:48=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Nov 18, 2024 at 09:58:09PM +0000, Sami Tolvanen wrote:
> > Hi,
> >
> > On Sat, Nov 16, 2024 at 9:09=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Nov 14, 2024 at 2:54=E2=80=AFAM Sami Tolvanen <samitolvanen@g=
oogle.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Nov 11, 2024 at 8:06=E2=80=AFPM Masahiro Yamada <masahiroy@=
kernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 31, 2024 at 2:01=E2=80=AFAM Sami Tolvanen <samitolvan=
en@google.com> wrote:
> > > > > >
> > > > > > To avoid duplication between host programs, move the crc32 code=
 to a
> > > > > > shared header file.
> > > > >
> > > > >
> > > > > Only the motivation to use this long table is to keep compatibili=
ty
> > > > > between genksyms and gendwarfksyms.
> > > > > I do not think this should be exposed to other programs.
> > > > >
> > > > >
> > > > > If you avoid the code duplication, you can do
> > > > >
> > > > > // scripts/gendwarfksyms/crc.c
> > > > > #include "../genksyms/crc.c"
> > > >
> > > > Sure, that sounds reasonable. I'll change this in the next version.
> > >
> > >
> > > BTW, is it necessary to share the same crc function
> > > between genksyms and gendwarfksyms?
> > >
> > > If CONFIG_GENKSYMS and CONFIG_GENDWARFKSYMS
> > > were able to produce the same CRC, it would be a good motivation
> > > to share the same function.
> > > However, as far as I tested, gendwarfksyms generates different CRC va=
lues.
>
> crc32() is operating on different data, right?  CONFIG_GENDWARFKSYMS
> computes a crc of the DWARF data, whereas CONFIG_GENKSYMS computes a crc
> of a magic string from ... the source code, right?  Hence the crcs will
> never match?

Correct, they will never match.

> > > > > > Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> > > > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > > > > Acked-by: Neal Gompa <neal@gompa.dev>
> > > > >
> > > > > Does this Ack add any value?
> > > > >
> > > > > Acked-by is meaningful only when it is given by someone who
> > > > > maintains the relevant area or has established a reputation.
> > > > >
> > > > > $ git grep "Neal Gompa"
> > > > > $ git shortlog -n -s | grep "Neal Gompa"
> > > > >      2 Neal Gompa
> > > > >
> > > > > His Ack feels more like "I like it" rather than a qualified endor=
sement.
> > > >
> > > > Like Neal explained, an Ack from a potential user of this feature
> > > > seemed relevant, but if you don't think it's meaningful, I can
> > > > certainly drop it.
> > >
> > > Tested-by is more suitable if he wants to leave something.
> >
> > Ack. Neal, I'll drop the acks from v6, but if you end up testing that
> > series, please feel free to add your Tested-by.
>
> Just my 2 cents, but it seems rude to me to *remove* an Ack from an
> existing patchset on the grounds that person doesn't appear often in the
> kernel log.  "We won't hire you for this entry level job because you
> don't have experience" etc.
>
> Also, wouldn't Neal be one of the people shepherding this change into
> distro kernels?  He seems to show up somewhat frequently in the Fedora
> and SUSE ecosystems.
>
> Is the problem here that you all think "Acked-by" isn't appropriate from
> someone who isn't a subsystem maintainer, but the kernel doesn't seem to
> have a tag for "downstream consumer of this change says they're willing
> to put their name on the line for this"?

I certainly appreciate Neal's input, but I don't have a strong opinion
about which tag is appropriate. The documentation seems to suggest
that Acked-by is _often_ used by maintainers and focuses on that use
case, but doesn't explicitly rule out other folks acking patches
either:

https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-b=
y-cc-and-co-developed-by

Perhaps Greg, or someone else with more experience with the nuances of
acking, can clarify the policy in this situation?

Sami
