Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920416;
	b=o79Mtw319zRr9PynS6lnLpunPLrsnP4QbPsKDx+8ekf1f/bZBrtBYqqh+pnPjQGi4P6K
	 ciCD8HF4BSWLTOtxhBOa2rHz1ymkEP5+b7jn+NlY0XtM7OawCRx/xbdT2e+nu2jDw78kY
	 FUDuXdPOdRXKj6lfR2+3IL75pUCPE+gSVC6I7yRv/OaNQTY8IdqXJKr039eLOaUSK7C6M
	 A1FPZBKS7AIUvfmj3jTjHz7tI5CSApfiL1FUm26I0zHlbQ7ZKM6TlIuLSZyQUHDdxYfSD
	 0Zno7w78WbjbJXqj5Jh+69Rpxud9qMaJZHceuKa17z0Y3Tu18iq8bJukd2xxNK6UbHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ckAIzUV5oWihOIEXseRYjbrEU/6METgnwVW7WGDvtlo=;
	b=hP5Csy+9NFfLsZW3jztdUhZO6Ipfj36ilfaU7OY3C97CAzRGr7n3/9+Nov3mOhw8CacB
	 5Z/CKJb6txBg83+GAJ5vXbbqgqHNqaCZHgO+aT8AP8piKIGkLyPwCS1abJ7elE3QeH8/o
	 9E8lLX9AQH9AJ5PeoESMBkvXEUizi0f3vjlvhkj14+OAheRcHg3luYOX3QtdMM67fBuHN
	 QUuwOo8ybRbXweNmbKhfQjHWmEkZyym3Dba2TaX+/DFPmzbKGoAynxMYzpd31vbUsH2+8
	 kcpbsD+nqs4rkYypmnv9LFGx+9w0yXkLCHi9nLqPHWrQzisFhaWeX0QPii5y0hcA0aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ux9dP6cx;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94262606A88D
	for <linux-modules@vger.kernel.org>; Tue, 17 Nov 2026 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94262606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ux9dP6cx
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso337895f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 17 Nov 2026 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794920415; x=1795525215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckAIzUV5oWihOIEXseRYjbrEU/6METgnwVW7WGDvtlo=;
        b=ux9dP6cxGHchfy+unLDQ6NmKaVT3R8pW2Zfa/bLFviUfqW7T1JZLWOGkLeMvqz7iUB
         zLW7dje3QrA7HvFJ9Z2e/BsWN7PkFukCWLlCC2sfZfe4C42kw1BD7+xJ9+K8ykHcfJhN
         xuB6p0p675+Q+8Ab4VBm/lPttSQUOT9MfXiQdtBTxIq64JfVXTUc/LJnriMOJrmqWlqr
         pVJv7iS/suULfBRGTO/rXud1wwmWfwrXIjLdPTrqTKyk72/ZF/FYEeTqn8YrQOIG851+
         XstWyYcmlUsM5ZYhKgaD6JN4csYJsgqj8fKhGxAJTKSZDhJpxLk/Ya/RZa7YSEnQfkFN
         FNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920415; x=1795525215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckAIzUV5oWihOIEXseRYjbrEU/6METgnwVW7WGDvtlo=;
        b=mJTMuLelEC6HPHNYCBkyaVFjc1PeO3bQZyjk82Gb/LiMLZMq/zHJmbFL7XHiUb2IH4
         hEdfF035ryCpMOq24YRNYTGjkKRYvYEFBr1yKlPcCz1F8gv7wlMuUDQ0B180AG26Hcou
         wv6Byv9ysc5eAMAnyrHTHj6i6Kxzu4jI8vb9/l8pIK0bEUmAq3bT9LKQyWoXZ/YvMIhX
         H8B2jxiLQrhtY9L5vEG+kXd8wdOQcLIU3tmputswu1rP7UnXW2riJ/mRboRt/VJPT/u+
         1LAMItYT8XvmraSU8NtsOKKBNm1Hj/HyOO/R6Q4hMnvo0fvJyHvhOCK/h3cNWOfInJg6
         +jWg==
X-Forwarded-Encrypted: i=1; AL+hErGTIiyx1uoSQzLnxH4nMIWituobkT0gqSI/k3Zu9hl+ShPdrEavhQOfGJ28tHukaw/DxijmaDVXfaUhaNlG@vger.kernel.org
X-Gm-Message-State: APuU4Z823VJfUvB+1z/K+QYOoygt1BR7O9k2OFw9xQX4LwfS0e37jPCN
	YC6+kZQZli7QPWlk8ZTA8MckDwCr5iZS6ZSm4uCcVJMjpZFP00/YZ9Oz
X-Gm-Gg: AZFdTZfxuLomZ0FfxwjrjRyXV1r7gffaMivX05ptV8B1q3sv8G8ncvyaqfOMNVpbtBl
	cqhr3epr0pU7qmkov3EaiNiy/t0Dhyzv7HKgxivJDzHQngQN9TN6YYhp1cLSa42xP+A59OoByxt
	xjTmPzyZ4BbxCxul7i1Y+4r19WvwGIYvt0rOTHp+Ya5v3pu9zjVHOi3JM4Bjb+CxnRLV98bGXIJ
	y6OJFcBXOlDoitsTewdVWk887zVM5k47zOV0g4pb4p1c1QUF7aijBoW9NuTuibU/Rd/aih92GBf
	fMI08OiOjo9D8NcvwLQf2v88Nk3f1zHRj7OSOJuiFvmGMOIUQ1jOrEnjLcGLGu2bYYL97eQdeEO
	AYL2nkec67NVndobeDHtxj3By9mAuXQooeyuStV1U+4ka2qdMByDltIrer9LQ03pz4VMUybR9fr
	SWhX1c998TTtDGso8bTE2w0UlmdpbKriQ9O1Aa7ayIRsR3d2uslhN1XXwAORbv15fFtCZSudFcj
	p3nwIE8+wF+1sjMWeVfglNZYs6/zfNJJztdYMh2Dn/6CjdoNesh1c38h6xU4k4U1zceenWVW38H
	/RUv3gDIDEfKXdurwzb9W4poieJdtZB3nh1al8W+fmNH/In+MwHIFz3sjAW1Hena5CvX/dMM/iR
	xb+tSkV6TZfs=
X-Received: by 2002:a05:6000:46d0:b0:498:2754:6a80 with SMTP id ffacd0b85a97d-49c725e538bmr20536616f8f.28.1794920414596;
        Tue, 17 Nov 2026 05:00:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm28207005f8f.28.2026.11.17.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:00:13 -0800 (PST)
Date: Tue, 17 Nov 2026 13:00:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 and KALLSYMS_QUERY_BY_ADDR ioctls
Message-ID: <20261117130011.05eee0a9@pumpkin>
In-Reply-To: <CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
	<20261115142431.1587690a@pumpkin>
	<CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Nov 2026 19:15:11 -0800
Samuel Wu <wusamuel@google.com> wrote:

> On Sun, Nov 15, 2026 at 6:24=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 13 Nov 2026 14:12:45 -0800
> > Samuel Wu <wusamuel@google.com> wrote:
> > =20
> > > /proc/kallsyms is the primary interface for userspace to query the ke=
rnel
> > > symbol table. However, resolving even a handful of symbols or address=
es
> > > requires reading and parsing the entire text file, which is often sev=
eral
> > > megabytes and takes thousands of read() syscalls. =20
> >
> > Separate from this, I've wondered about separating out the /proc/kallsy=
ms
> > code from the code that actually handles the symbol table itself.
> > The two parts are pretty much separate.
> > IIRC it uses a static function to get the symbol type (which does most
> > of the work of getting the name - which it also wants) so it isn't
> > completely trivial.
> >
> > I'm pretty sure all (well almost all) the changes will be lower down
> > the file than my changes and won't cause (hard) conflicts.
> >
> > I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
> > in userspace for testing both, but had to cut the bottom off kallsyms.c
> > to get it to compile with a sane number of definitions.
> >
> > David =20
>=20
> You mean separating the core symbol code (top of file) from the procfs
> interface (bottom of file) into two separate files, right? If so,
> seems reasonable to me, especially since the file is approaching 1000
> lines even before our changes.
>=20
> And agree, even with both our patches, most functions can remain
> static in their new homes.

I just tried it (on 7.4-rc1).
Only had to make kallsymbols_get_symbol_type(), kallsymbols_expand_symbol()
and get_symbol_offset() non-static (added to kallsyms_internal.h) and
split the file before the definition of kallysms_iter.
Then tidied up a few #includes.

I've found a much bigger problem though.
All the sprint_symbol() functions do unchecked writes into the caller
supplied buffer (no length is passed).
While the buffer is (usually) long enough for the name, there isn't
guaranteed to be enough space for the "+0xoffset [modulename buildid]"
that might easily be another 60 characters.

Some of the people who have modified that code recently really ought
to have fixed it.

David

