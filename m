Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF531F983
	for <linux-modules@vger.kernel.org>; Wed, 22 Apr 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869295; cv=pass; b=tnImTVrRQdIc79IWRlreWXWMycrhZiCX3H+fMZiD30vOmXyQVrJLw5xyqC+NddaMZyPyfIYDa/LUTHFHXpGrvsm4E/pVyI1l0kQAja3ms7VWG65SDtAhEC1tHP4OUkdmVMgu7zqXFW6/1ZNxT0kJxY01ryI5FyWQmhqooaro0Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869295; c=relaxed/simple;
	bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyDXJLO3R4Am8/IZpi2ExfGkgm2D1OnzvXJPdPHoEeFIGdBR3qPcHOlqIW3vuXT+aHam4j9HkfQfGVNjcaUxEKh+5zsDtgq0DOGMiqMPkwjGriJ65cY7epZeUCOLwGZobUSq+P7sPAuS9uQKiFH8n1V73FQaer5IKQkgTfcBC1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb1ShRys; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb1ShRys"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d734223e4so3842375f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 22 Apr 2026 07:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869292; cv=none;
        d=google.com; s=arc-20240605;
        b=W0CADse4y5uv2AWKRhJNfpKiFdYj5sV1C4QCjCoqTQg8+K2G2Nd5Q87Dnlr2+cU54r
         XBBwjHnIhrv3jkyydCwVzKcqCrO8sphy5NrYZGa3hGjdWIu+t/nB6SqylgiyN04MjLxM
         T1C8/6ZocZFrFgk9GOUkmkxtrNmBKBRkMQd+kJ0CCK42mQKSqtcda+1PYQeroLs9rIjW
         tP+ykyGOxyfeEw8ohjvVsjaWUX3nELq4cepokteahRyfXn3GRFq8LMIxesEtOXBwVyGy
         qBtNLzJCz8yddhdl3pZc3bmyIUjD860jRK36IrVbbmb5pAlyrWKOAoXZ8BUD9cAnxk0G
         3WCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
        fh=EgmZeTy6ETu/ySuwulstmwqKd9PPlZ7lJrdjz/VWeUA=;
        b=IOZP1c5abu0+xV1kyQgeObv+PTjywxLoJFgmrvOmVSjjJfR5qS5WObFYt7Ywkfke4l
         517VdcPyyfW81pMAb8GYWyd9QUMfl7y+LZfhpaNeGJAJGHgWjZkZmNWf4nlCyx/0dKqA
         xBQdS4sj5/DTmEgp+RL4Ua8v/JtbPG33FqXSV5w5B2+VtHX8GFmuOFITM+1/1M2G4V/M
         UZfFkrN0SVYmC+MfUbVePlW4PD/yCkUXMjRuDwPBx0UjQyZmMOqtaJGiv1MxzJQYsn9B
         nYXI+V07MLaMqerBz7YUyOT/E+HgTLXQ60ACD0OBlZbBT+qtsPAolCCG9oRelW9o17Hk
         rTLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869292; x=1777474092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
        b=bb1ShRysobJfv/guBXGH2tIQfvbJBdXF37+QGzOj6A0jZcum/r49058R8xu4XpGfk1
         MaxgLaeXFrngS6o48HliqwXVOUOhfWNflD3LXRspe9YhVzxR1AcbKW9pljOMbzeL4yxO
         vLVbWAB+nKgn90E85+kPvheBuhUPnNS2oTeBazDiWElY3wOKGCBl8C/NjbA5FnVcImRO
         RoUGscdYiQR64jcqkyKdaeY0RygSVzEu1xUW5ctXCsgYcHEt1MLusjO+28jwXtpMkMs+
         mf1oIo0UcRoDwuNgfN5Wgclg+XaMwQV5gOTBhEt5DEc1WEh4YdlZQmAbiBRpK+2odnY/
         b2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869292; x=1777474092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
        b=roeWrAxcEGngoJnzpYfopZROoMWDIiVw0ouPnJEqpRCKQVAFv2PfUExESMl/U+c/sF
         8rZWdF0SgfnWxvSUCGV6l294LMNrmLEjlpRmtrSdxElXYAAE/6ECM9VsZy2P7aXR+DHD
         nYPOKTud7Agc28WuOVM7ViuK2NRfLBnJSqts4BdIOtlW4XU/cUS0w2bme135Scw6wCec
         psxmMts9s6nEQIthdRGo21wVoYD9T6HpEkf8cQW4JS+XNkzW8td4ltfp6HCI4uX4jRXV
         cVcjWU3HqMasW5g3PeFtBtHFsBzSDA5NZ0LPHJ0HDxNzuw2htxJ2GHTTTVU3rR8DDWlL
         /KQg==
X-Forwarded-Encrypted: i=1; AFNElJ8BWYkyx6mpQPAI0SDigCsxT4GziWg4OCAWSxU0+rm1YP8yRt6ceWe027L0rp4VUXXaQ+GQ6MY6C0OtA8bt@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPKvQJjtlHjuXu5dPBni1QVslBHEM81xfs8vEV2aQnUzcAlQ3
	LB4f8UbSqWWHygzJAkB5pHkyN5btCresWM9FIzel4h09QWwxYg/RCookuSFSyFPXpWXM0VlLmvK
	x2LpMHw29hY55uxUfC+wKEGuzo7Oz7i0=
X-Gm-Gg: AeBDiesofP4adKFJ9KSc81p4gbWfBUcTDVE3lv/kZc2TKeRs0mgU8i5dWirNdP9CpKc
	MSklcHrKF59na2RdHKxiyB4wRA92QIWZlwMdv+O96/x2RkWF3Ul/gHW41XhpXq6wnRWKTooOKD8
	/fzm8HE9wnT53ildlnQFV9jW5ZVWH7g8z875NPMHBXEYNNcVYD+Niuog4jc+VjJS7cwE9AKTcVC
	xU6PKOjt6EnhW+7xWBAxt/8Zc5fdKUBcTxHOOKf1OPCcAivIlBHVR4lE8iaJNT1U6XXEKKSZs+D
	+h91SuTFUcEZFCIpXKIHjdgjc6AWbSh6S36uZWQ3rU1/8LrDRw08tVVKo745E8jsQEKB1QhPgKb
	aiVnUBXhGuffDhnfucDfeEvZvidoZ1byxZTAu
X-Received: by 2002:a05:6000:2dc6:b0:43d:7512:6f7b with SMTP id
 ffacd0b85a97d-43fe3f35785mr36196268f8f.5.1776869291840; Wed, 22 Apr 2026
 07:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acLbnMAPrHCpoIpr@laps> <20260325011853.657295-1-sashal@kernel.org>
 <c7a8310e-501f-48a8-8ad5-0a40d8b3836b@oracle.com>
In-Reply-To: <c7a8310e-501f-48a8-8ad5-0a40d8b3836b@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Apr 2026 07:48:00 -0700
X-Gm-Features: AQROBzA3qHbWnHv7v7Pdc9rqcoF99lBmBFrCQdAyyZbQ78QmK7wYiCIv_i6_yA8
Message-ID: <CAADnVQKshVai_srj_X_T-1AG3QH=VHymDO7Z4JowLcbC+jjReg@mail.gmail.com>
Subject: Re: [RFC] btf: split core BTF parsing out of BPF subsystem into kernel/btf/
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, bpf <bpf@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Gow <davidgow@google.com>, Helge Deller <deller@gmx.de>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-modules@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:44=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/03/2026 01:18, Sasha Levin wrote:
> > Move BTF type format parsing and inspection code out of the BPF
> > subsystem into its own kernel/bf/ directory, separating core BTF
> > functionality from BPF-specific extensions.
> >
> > CONFIG_DEBUG_INFO_BTF currently depends on CONFIG_BPF_SYSCALL, which
> > prevents embedded, automotive, and safety-critical environments from
> > using BTF. These platforms often disable BPF for security and size
> > reasons but would benefit from BTF type information for crash
> > diagnostics and debugging.
> >
>
> I had a go at a refactor in this area too, and it's pretty tricky. How ab=
out
> we start with a smaller goal; making /sys/kernel/btf available to userspa=
ce
> on systems without CONFIG_BPF_SYSCALL? This would just involve a small re=
factor
> of the BTF module-related stuff in kernel/bpf/btf.c, moving it to btf_mod=
ule.c
> or similar say. No need to split out BTF parsing APIs from those actively=
 used in
> validating BPF etc, since a non-BPF_SYSCALL system would not need to pars=
e BTF
> in the kernel (just make it available in sysfs.

Small refactor is ok, but in general I'm not interested
in complicating code for systems without CONFIG_BPF_SYSCALL.
