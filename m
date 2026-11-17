Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794885328;
	b=aZO7NMdvUG5ge4wEiE8lVcGkDUFP6wcPw1GjazsQaXRckCQDUwFWBY/S/H82e1LJKNsG
	 eRcd4akJLc9oV3D+1EuMr1a2uF/fSe5+77xBKVBbaW6Ft/Rwx0fP9OzHZfZDzeqzvY7aJ
	 ICkAFeGhrszA5Z0sZbrx0h3gw8/dMJE9QMunHiU1BxeuJzdkWfDkz80dt57IMlE5kia0n
	 uENeBj2q6fKLNaoolflSmzGKqs1dzvQngSIQq/tSHOyAN8sjzsaXURN/g0WZ+YST+NK/U
	 LmTOwzxAejnxHq4PuO4mAGocbr2lfj6VZZQBHdfGUcJv+TvwoXTMuS726tCH1XcW7jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
	b=SpDap7UxfRxwlKhY8qiPh3d1HBnx5sA+CYC8eqlE9ZMMyZUpBSQVuF9mZsk18yLJ+Atv
	 luXgPVANfAW8OnhCTYryTtvcl5jcpfBlryIFSBp66Ph7xruDC4pTkD9jOPCiDJ5AYNU/u
	 fmcNoi0pZBW817GwcSRmepFYtEh/8nA47QX///uDurR1S5S6YH1TOCbkwVhkdE3Sv8uub
	 MwCHhh+kP17h66gSrnb49w7Sp+irNChBP8pZQp6W30I3gGXMjnfOpgHeCPEXdVuFxG7E+
	 e/bw1odsBa5t7ZC8GEfR3EdsjcWDr6tmvP1asPL1fdxtSOBAREQ6BthWfnoir7EXoOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWuE0zna;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E02606A331
	for <linux-modules@vger.kernel.org>; Tue, 17 Nov 2026 03:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E02606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWuE0zna
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4682977f9aso599517566b.1
        for <linux-modules@vger.kernel.org>; Mon, 16 Nov 2026 19:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794885327; cv=none;
        d=google.com; s=arc-20260327;
        b=D/bqKhvy321t60EwHg2GzxR1Wpghkt2U9QQ1F7Ipd5+FACwYn7ib3HLWHtaYJCIAUy
         dBUBTrSqY4Xh7LB9PgiuUvXxHiOj04QwDkvy4OYZLC9SiHj9QwUsd4eEYvsN2qXCsBFa
         Z3Vlei0i4AgrQnx5J1wovWS8kgEEVkV+xREYLOPP4gm2ymDYmhRmlxHOcNTohstDOURI
         G4fDF1lzO07kdukDEheU50f1qk1S+b47NRpxhWO8wNJMhESkiuqw45Ie4GwcjuPpjCrE
         fyhPVGGJPrp89r4uNsMQ04aJt9t4mbo3j1IySYzuqyMW5KSFcUfUiQ/0CrFxCmneOHCr
         KqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        fh=b7CnaB3u5iPyiUPxrefzHv8gdCsiw0WB0SFOvslFrc8=;
        b=sRXkwrvGquv8EN+QZ8wZOyTDRCj2E1RLLq7m+/hnhvnpsHENHJ8B2Lg3dVO3S9w2s8
         SOQJOTrHIEA26K9IwftPgPaQ9XWeDST5h8KBTMoGcM9DnZ5V+iZRjum3+WTxpFQFc17K
         wHHL3DaE4zb7u+dOi7Mx+vqw66XyigzME+RuvE7dfcR0HiUC9L4hWqAToopuPtxxnWKh
         aVATzAyWXP/+3nJQ/W2W2cQbAH5DveR16BMqByxK5aXsSRKnIQSBP8r4MItihTIQH8sm
         1LMXMXyC39+ldjcAZPxCl5f/HBzQuIW4vCTaX7ENt5PsFMnx9KFBOuP9XaK6SEsWZ9qx
         +lQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794885327; x=1795490127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        b=UWuE0zna/Kej6vRfmnnkBRPiB7MtRAOmWnZDUwfDZnARnTtWa0lZ918fHjZc6mu5UO
         /2+zJyxEYftdneZsscW0DL8Fvl081Y38tQO4Pv5tUIPYfcIIYe6CjwGLqcKBSst9Gk21
         HyjrRa3A/10hlqRod0LbCztyuvg1+0RmyX0gzRFwGRR3oqb5tPu6tQU03asd4m3tC1Ly
         2jBUNoTFraXXJMf5dSQasvoZ/LajiRGFP3fxeQbTALoTqP2ZEYO+PCEtWNT6HsCG/4y2
         Qq35/dZdjfO2Tkf3aMOsAIjY43RWuC/9l+8ADKlIptRxOOPmsxJVEZSYuAL1Y41KbuEX
         BlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794885327; x=1795490127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        b=w4VQKFb07qLiVvRUh/h41UFFhKnw1zssjG+yqsRt/DdrnvwdPijwmaAxOcOgEmB1v+
         qSQYJzPf80gDaIUyCL7oqnrh6mfSwd9RzvE8gNdmb3NJ8cXGusLGIMKf/HpjseqcN9Sb
         Hu7rjuZADjDu1Os3scMDlmzg7duSvR3XtuSOqlODxw6fXNRMn0oWE5rWphSekZgozR65
         ZG825HHzol6WBBllyUdv/bAp7Wz/5ebvRNWGqFByL/c/V2MpR38tSwcBq4f6syZ8fHUe
         h/HSWJENSODbqAwWcv5o0d/oL9HRHlDcce2WyRQwdhJlguguBvK2MGKDJhxq7FXsEx8w
         xVqA==
X-Forwarded-Encrypted: i=1; AL+hErFjnc/BdrvO3MmN7TA3e0FBwxZ/NrrxTeCUHUChT7vPqstdp/M3GeoD6O5rdoUSZgJaHnbGxsRi/RLwjcYM@vger.kernel.org
X-Gm-Message-State: APuU4Z+PzDQr0f6Kgncbf3jQ2+obhbFMiPiNEeYuQPV+Y0vf4mhArbao
	fMCwARUWoPYW8zgjMXWPWqLjQcDi6sEMW3fitni5wa3Mo54UdhUa2zVLQoFhoj2mtle1RNkY9z1
	uMUZb5fxUXbwhaXUhm4FgF2ktzwTDG4CFpGEk6Xh4
X-Gm-Gg: AYBFou2VeHjcx4w4+AKIgnqZpBzP3Do8eSRJeb+6KCvClnCz/SyAFuHyOdy/rPMpKRT
	4t+86fEjsCmVTTBSKUqJuMDP5PhokO3OeG6sl9Pqucbg1xAV5PUAhOsZcyoNnuNAZue6bMbHHKc
	szXnxZebOososGW+GtWicBnF5rdzi9SY4BKsFl0Zp7sdmLPwQJGWjqM6Zf/1hjcaVE/LRdkunoy
	uanedhQIMjOe0paec+YEbTi8tJj4uyebRu/8PbfMi/m0uhudErIbUy+R9hVN9zivk2zTrGpY2v8
	HYNqFP3qeIyGQRzxao+Qqq5L++WCtNpM8tCBpLlcj+k458nsItU0iSaRhW8jjjAGJSRQGxD4W8X
	tc4n0LoPif16XOyXrDGTOvgUkTfNygOIgCieixuSR800PV/9CBu2fiGLmY4e/74HrttXK794=
X-Received: by 2002:a17:907:60d3:b0:c31:8441:35ff with SMTP id
 a640c23a62f3a-c50968355eemr1101863766b.48.1794885326369; Mon, 16 Nov 2026
 19:15:26 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261115142431.1587690a@pumpkin>
In-Reply-To: <20261115142431.1587690a@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 16 Nov 2026 19:15:11 -0800
X-Gm-Features: AclHuK-iBEn00_VVuz6qjGQnwYZ5FRJ6bny3VEMRskBOJf02b9BDmwbxXueDduo
Message-ID: <CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME and
 KALLSYMS_QUERY_BY_ADDR ioctls
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 6:24=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 13 Nov 2026 14:12:45 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > /proc/kallsyms is the primary interface for userspace to query the kern=
el
> > symbol table. However, resolving even a handful of symbols or addresses
> > requires reading and parsing the entire text file, which is often sever=
al
> > megabytes and takes thousands of read() syscalls.
>
> Separate from this, I've wondered about separating out the /proc/kallsyms
> code from the code that actually handles the symbol table itself.
> The two parts are pretty much separate.
> IIRC it uses a static function to get the symbol type (which does most
> of the work of getting the name - which it also wants) so it isn't
> completely trivial.
>
> I'm pretty sure all (well almost all) the changes will be lower down
> the file than my changes and won't cause (hard) conflicts.
>
> I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
> in userspace for testing both, but had to cut the bottom off kallsyms.c
> to get it to compile with a sane number of definitions.
>
> David

You mean separating the core symbol code (top of file) from the procfs
interface (bottom of file) into two separate files, right? If so,
seems reasonable to me, especially since the file is approaching 1000
lines even before our changes.

And agree, even with both our patches, most functions can remain
static in their new homes.
