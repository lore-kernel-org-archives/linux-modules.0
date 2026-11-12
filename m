Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456854;
	b=fqWgR/H3XASs4wrRePqh2MFQSXaqeENj0boMPh3Z+hkwgvFm2gtDUjsEApUGYQosA2Uh
	 QKvOVfOXb8lSCIMiQFZapyQGvFAjIGX2PBwz5MpoRcJslGs3wDhQILOj8NdrADtLsIMlx
	 Rmwb7Ju6RvI6ungOFW5P9YmxR+AZ0owF03BJvHi8OxYkny45Hku7eNF7zp4gPn18c6Ca/
	 35n9/isYsqyb1zIE3fBLck+Ff3yamvVI0ZmqNr4GEsBCKth7RIoLmLUQsFq+8j5WLpRLW
	 ci/vRrRFnE1dpunrUzvU6mk35xEGKIMi/6bvJFSe3E2Q38z1krtKEfsIVZWBUdji7Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456854;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L+Il5N3BH/2acwoOZB4pI0vrBC4sMNLVBHAemIgrgNA=;
	b=b76f3by9n0ls2YT1Vsy+uyvgLuK/3vfzo4Zbbqe1YvUfTCa9e6H0O14NVp4un5GrjTPJ
	 ViBarD90fvhCcLuqxgn4ECFGsE52G7h/azgX3xqzzq1pTrA3VOb/eO7IGz7BTtCf443uC
	 oEiU/1eHzIR3Hj9jy6GuafDtIBpvj6XZsGQmFDC9EMFZSvM5JuFYGmo5eybzSGqdwcNVi
	 rTzZULDkodyW0cpgVoFo2z0D8or+VqOfbQWPamku5tFhYiqChuumH9a8hyda5Q5seJTym
	 lneQ6+/yS1IsTviWeEWVNUwHV93ck/Pgz/uNqf6XsHgtyoQh2+A4vEk7uqfCF52WfBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krZcBCxO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60C606A324;
	Thu, 12 Nov 2026 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krZcBCxO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3638C1F00A06;
	Thu, 12 Nov 2026 04:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456853;
	bh=L+Il5N3BH/2acwoOZB4pI0vrBC4sMNLVBHAemIgrgNA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=krZcBCxOPZ5U4C+Ww9jKZi3gSHM2Nc8MQoC/LsQIUqBhaB6ybm7iigFB8B+UgvZ/1
	 8gNUmeqD4E00lq3mdw01rRWOuZ7r6kmv5egXjt99BebgX/5VnrINwZPZWBMRc9bIWa
	 Meg88x7rT4lP2l5d6TFSP+HQ5cH2Y5+judMmwE0Pmvr9yLKEpTPbBaJHCBWxFJWmVV
	 4BJ4nNHEjGwgbS/aLTSpWRTqmLVTFRwFYpLurCiF38PQMD7Qs00svrUOwbsmJ+Ougv
	 LprdSqZyoZ2DyXZgoSxY+pKz7cvckmmW7XzWdIZWZJ+4lqeE5ekSzlR6anXuCJRvwB
	 QB7FY9wwPn+fQ==
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
Subject: Re: [PATCH v5 05/11] kbuild: batch module finalisation
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
 Kees Cook <kees@kernel.org>
In-Reply-To: <20261104-build-speedup-v5-5-0f6018be8dae@kernel.org>
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-5-0f6018be8dae@kernel.org>
Date: Wed, 11 Nov 2026 21:13:34 -0700
Message-Id: <179445681472.2545603.12656481753245333767.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=630; i=nathan@kernel.org;
 h=from:subject:message-id; bh=y8LsBm6D0xpdjJg/+gkm8Yq0pgu97nlBXctDVx4Veks=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlfbT7dc7z2bk6YXLK3l4bmK/f1N464rWxuP/xh7i/Zh
 6+Ze6/pdpSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJ9FUw/K/ak3hN83KpWGll
 iJnEKn1XNuF3Rge1LJJ6y5NtX/q9DmNkWCj3ii9BQy8wqFLZT3XHXIZM4bKN6zsT2+Ytj/BX6Uz
 jBQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Wed, 04 Nov 2026 18:20:23 +0000, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> With the .mod.S change in place, module finalisation on allmodconfig builds
> consists of a large number of very short-lived jobs.
> 
> For allmodconfig x86-64 this can be on the order of ~22,000 jobs of a few
> milliseconds in duration each.
> 
> Each job entails processing ~22k .cmd files, so the combination of heavy
> overhead and small individual job results in a lot of unnecessary and
> repeated work even with all cores being utilised.
> 
> [...]

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan

