Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600986;
	b=SyL5XgmrjesRTGPOyqLlVu7Mk5KqbLJNGC+LzaARyByinq6M151FWeXRAKJ/nvvRefE9
	 a6jXISObp8bmwfh5fLJ76AJaH+5impVplzvklnZOp4rWCFGEP+d+J+YMJSy2X2Hs/IgAH
	 s6czXH5wBuOWHgOF4t6GbvlQ8P25v0vCrTjJF5Nws9zSq2kx/5ZeeO/2EY9yKp8uJOVFC
	 gNhdAMiAfQ5dwl8Y9EasuPvvgAmR1a5h3ygWmSoSOCcgaFScinR2M2Fu0Z9cGPvV/b3HD
	 /Zb6BCLyiMBobu2CaDoKUcmuWVGhUoCBIvpdGiZyiOW8y5jzJMgDuJvkWPvvHy92Dog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O13UsNDL/bH4zWwx+DfiJHWknsxleVix5d+Kxzd1OWY=;
	b=sAHm8Fu+ZGgy3dAch1lEiQ01bzNHiyWyZzK+wQakBAe7KkTncrVfZrLRcDxF61f39ccm
	 VFwGIVl+vDTnQc4NLFJcbSoXJtngYad9e7yK+tF8nCOUPhu+i3H0BD374fxzAw/xIiaBQ
	 NVcOKNd7ToGkRw+74EAfmrBrmAPEEi8ubvVYaSNM2ZTzbp2nEVwR5ZFYE6FY3VbnE+CMs
	 rbwJWbZmrlBjdIX0v0HJ6ldS3NQFfLK6Dk7o63Yj9GtgX85uED0aMc4P2x16eH2+P06I0
	 JaHF570GnGtFoQcUSc+7ywmkKZ0FnzCYyJWtwdBVJHajkdGVQEUE1RMT9XXHD4v91Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="InI/35eW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 83E7D606A323;
	Wed, 25 Nov 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InI/35eW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 645291F000C0;
	Wed, 25 Nov 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600986;
	bh=O13UsNDL/bH4zWwx+DfiJHWknsxleVix5d+Kxzd1OWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InI/35eWuYB+ucgg71M3f6aPF8ims5sfg7vm4vHs+tKA/kGD1EhYahM6PohlTEXOM
	 KSuOJFvMgd3UGH79fBGuikXd7XcjRp9hfwqD9e2+qRNB3BiOrlITQpW9O8EGrMNQJO
	 mYzpirZVSsEDKNkFZRq0YSFEXmZDA1OLGni3xQPh4pdiXlqjkEFfqjUlXZKhC8ye70
	 PHJ2ojeXxj/3tOn8pf7KlZjxYfVc4fLXD4kMCpbXXnLz9XXW/GBk98lX0czfZ85NUQ
	 RyQsWlnk+OTGR29+ZoPIMhQ2oZUOumI8CpcBuqmAFYQdC2H/x+8iV70QnYcBL26tRv
	 FsSpPxihE1/zQ==
From: Nicolas Schier <nsc@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Nicolas Schier <n.schier@fritz.com>,
	Kees Cook <kees@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 0/7] kbuild: significantly speed up kernel builds
Date: Wed, 25 Nov 2026 11:02:54 +0100
Message-ID: <179560086157.3880976.7669895635153146949.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Tue, 24 Nov 2026 12:20:10 +0000, Lorenzo Stoakes (ARM) wrote:
> A typical kernel build consists of a frustratingly large amount of time
> spent stuck in single-threaded bottlenecks.
> 
> It turns out that there's a lot we can do about this and doing so
> significantly impacts kernel build times.
> 
> This series makes allmodconfig builds up to 36% faster, incremental builds
> up to ~70% faster, and noop builds up to ~90% faster.
> 
> [...]

Patches 1 and 3-5 applied to kbuild/linux.git (kbuild-next-unstable), thanks!

[1/7] kbuild: calculate list, composite object state per object
      https://git.kernel.org/kbuild/c/d3c49492
[3/7] modpost: cache section relocation mismatch state
      https://git.kernel.org/kbuild/c/db57178f
[4/7] modpost: emit module descriptors as assembly
      https://git.kernel.org/kbuild/c/4894ced3
[5/7] kbuild: batch module finalisation
      https://git.kernel.org/kbuild/c/81593e2e

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers).

Patches applied to the kbuild-next-unstable branch are accepted pending
wider testing in linux-next and any post-commit review; they will
generally be moved to the kbuild-next branch in about a week if no
issues are found.

Best regards,
-- 
Nicolas

