Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456833;
	b=iEvVTBeqK3z5OTGOCMEKxt8U8xU+MgdWEqiG3pnV9yNczeAUMEOU+JAK4DTYZ1xAceJx
	 HQOawe5CZpcyhrR357LyFPgLDO3ts/piIqRSppPOa4k7BlEB9cUWhUFKD1jTBXgwwd/uZ
	 P7m+E0jRMVhaIpfAR9p9Kk0nw3xmMLlYDXRcQu2hu4Q/i4ZHU1tOKgGIry9XDgbuJlXbf
	 v4RKuIehKpn4bIAenmK7SD0EofCByH/UeSv0615iSNIPtKkoRA4oGoAo+WXlFrLMRmEJ0
	 JdwCDB0WV/Y0sV/Nvbf9s4+H3zNeZ8xYiIMF0oT9toedSCqdyB77wZXLQFuQ9pMiQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456833;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rODyJNP1eRbwsvo0ejMbgwXsyozwZdJn6vA9ylKRYvQ=;
	b=3xGrPNQ+AjTfw3WrDLqfgYZ5S+8VmqddPkOj8BG3JvWABT5Io+t+6gp2rE03XD2yPqPA
	 LMBYeX0D82rZg9oO2rhG8/gYkwq2znak34ctikCTdbBTm1/QPYN6W0w2cQwW2DfGmCh+u
	 DnaZF22IY2ZK4h9BU7v0RY+Feq8ae1g0AsJBOOaxFz36es60tBTVMa4TPUJqmoDgoTRmK
	 cDkLb6uhgmpNDKM+HoezowM9kqOh3dfCsjYczlj/R26l0DwSgN7r3I4nV3H+u1zVMcs4c
	 U6RcPw+KlSg9D26NEOoH5ggK2EjM9wO/dSyB9Sw1wBnx8C5GcgR50pjtprhyfC11mjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D3/5FXi6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9D606A323;
	Thu, 12 Nov 2026 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3/5FXi6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC71F00A07;
	Thu, 12 Nov 2026 04:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456832;
	bh=rODyJNP1eRbwsvo0ejMbgwXsyozwZdJn6vA9ylKRYvQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=D3/5FXi6a7aKp/reI0nFI6ZIePVE4SbRO8JGnc9CmOQNnn6Qn0QkK/HLu+Gg07MHa
	 h5ighos4A75bJlyWyJDTlHOruB8eHEpHudCCQax8FKVO5qMTv/hCAxqo65Y2DYqNZ9
	 FUme+1Qkdfanel8T5gqrrMEOXE1ZWuR8VRox8yS2w+N8HDkK6hd391QKH1bjKIWn6Z
	 vtw3tBDr8j+gqC6y1WgpGwC2RZCkk00GmiCJIj3Qxp5zYj4Bdeyfix6tBdbTEokMjL
	 43TfO1YewkXxEhRoPM7/BlUUUQHNjNm4sunJ8dIjgyEdtQYrnXx8Zq8AaiAVBmFwme
	 IK018KGfQOsNQ==
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 01/11] kbuild: calculate list, composite object
 state per object
From: Nathan Chancellor <nathan@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>
In-Reply-To: <20261104-build-speedup-v5-1-0f6018be8dae@kernel.org>
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-1-0f6018be8dae@kernel.org>
Date: Wed, 11 Nov 2026 21:13:34 -0700
Message-Id: <179445681468.2545603.12225674913375832812.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=nathan@kernel.org;
 h=from:subject:message-id; bh=TmgTJdW29nIRrm5geWplrT1THomTV0P5Pwume7Dyr18=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlfbT623t8Qe33Z3PYQk9nKHP/fzr+2PXvL1o4TlseXr
 Vlbf+d2SUcpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYyNmfDP+M2POs2SffEzK4
 NlHnmzZ/CkdQfqXtN9ZNL9vOeTo/MvzMyHDbvzXwb9OO7nWe66cfi102yX35RvP9f77ZGvs9O/w
 8+yILAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

> When each object's command line is expanded, kbuild has to figure out on
> multiple occasions whether it's built-in or part of a module and which
> composite object it belongs to.
> 
> This causes the time spent on each directory in the kernel tree to grow
> O(n^2) with its object count, which is especially problematic for instance
> in drivers/gpu/drm/amd/amdgpu with 310 objects.
> 
> No-op builds (i.e. make -j $(nproc) when nothing has changed) are
> particularly impacted by this.
> 
> Fix the issue by calculating this data once and looking it up thereafter
> instead of recomputing it over and over again.
> 
> This has a particularly large impact on allmodconfig builds.
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 defconfig, no-op make, gcc            1.1s     1.1s    -0.02s (-2%)
>   x86 defconfig, no-op make, clang          1.3s     1.3s    -0.01s (-1%)
>   x86 allmodconfig, no-op make, gcc        15.3s    14.5s    -0.83s (-5%)
>   x86 allmodconfig, no-op make, clang      16.2s    15.5s    -0.65s (-4%)
>   x86 allmodconfig, touch mm/vma.c, gcc    35.0s    34.3s    -0.77s (-2%)
>   x86 allmodconfig, touch mm/vma.c, clang  33.7s    33.2s    -0.51s (-2%)
> 
> Reviewed-by: Nicolas Schier <n.schier@fritz.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Seems like a nice win.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan

