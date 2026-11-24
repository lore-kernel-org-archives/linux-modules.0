Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522871;
	b=s7z2Bv28IcFx/wj2NT+rz+BM+TMLBI4093MKwTIPFWksYs0rYZsAPYM8/m3VgfKXLXcN
	 dlpyD852Q5+ASX/1uU2LNT+DvD9yimUwH+5tlCvDD3WCjoEyf6xKF/816IVbsZQpBvpN9
	 I25idMxHg9zTviER+BjOUA8FcvpUe8pOWLrTNdsKz45HKkhlBObHvZdXu2NK/jIPkFuMO
	 5uPLAXhPoJnlNvFMPZ+c3lS29yNaF53Z2rr4EmRKUTroeZ7g6ogB2IhBKj/sNQ+yoCdrg
	 qtAf/+reiE5Gk3eS/kskqKjAn0jR6hfpuRnMPB4Cz3zU2da0WVWPXpxnt3vpxkGDoPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522871;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2vd0lkV3pSEw1YB3BM81maS9ofHw8xSFvvIox941e6I=;
	b=JBFvvBZxa7bRpvQ/n6uHPbJGcOnPsqwviKLJ3GMm/l33X5QAPueBGD+9ktKh52UalRzL
	 psxSti6wWOWrYOzUzOSeNGrrAxeW3aPL6zOtODHaYbmKdhi3gYTH15TqmoRe+GT2ujxdL
	 VLFMreudetkRmzva/ag/F5ySGvJelqqaNBxH6LPeN4HRFegSmPGHeD/QEh5r3IitjHmOg
	 g7W2RIcC1EGa9dZfYK84MniXWlVs2JWguBCSE3B/6qLAaZqDG7A831AYuxfcwdQz96lZ1
	 Shr3gIr5vtwa8DX94kry4UY9AzYFakgZawwK3Xj7dZS88QexsqXOE0s6iV7gFBUgnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDvDd1u6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEC606A31E;
	Tue, 24 Nov 2026 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDvDd1u6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869231F000CA;
	Tue, 24 Nov 2026 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522870;
	bh=2vd0lkV3pSEw1YB3BM81maS9ofHw8xSFvvIox941e6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oDvDd1u6MMJnL/sdm47qfZdNmfNs9S111+wHNsyXYNkRjD77+oQZKu7nqVOvq++iz
	 anIuR7M9DKjWg2ghdZaP31Y632RD8IXs4UhCcw1ZV8sLMb1JANYf3o7/yMZEi+F4HC
	 cxnmPqo+mo3NTZlYNvXUqVpSJYL8vn/1EGu7m4Z3VEh4yYEMM8pbsTkHQMfSIZaFCv
	 aIeea7XAFv1tb/YwqA1QTjv0eMRdxjW/3aEWxioYvvNUvuxEQqJXNSByH8S8JWgLWB
	 eC+vBOcq8JgEd6udM24DkwCMrJQQuTxk6vsh+M3TWOsE5nrQlgvjPpD564BL1CJamX
	 3PCg0qONxGLZA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:20:15 +0000
Subject: [PATCH v6 5/7] kbuild: batch module finalisation
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
Message-Id: <20261124-build-speedup-v6-5-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
In-Reply-To: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
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
 Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>
Cc: ljs@kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5037; i=ljs@kernel.org;
 h=from:subject:message-id; bh=YDEGsMxDYmf2aV1efTteExKpwXW2IC5h/4SlO9ZBB48=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZG/47JRiUfn0/d+NzUdtnR3NlLponFd9LF890mlhsu
 +zxaza2jlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExE4RMjwzILk2srfmjFTbjc
 PaVGYvv/xPqAg7HOVfNtI148a5huuJKR4fNDrdtFkQXnpSXPnAuW7br4R7C2JsDMsM7zodjsf8d
 /cQEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

With the .mod.S change in place, module finalisation on allmodconfig builds
consists of a large number of very short-lived jobs.

For allmodconfig x86-64 this can be on the order of ~22,000 jobs of a few
milliseconds in duration each.

Each job entails processing ~22k .cmd files, so the combination of heavy
overhead and small individual job results in a lot of unnecessary and
repeated work even with all cores being utilised.

The solution is to batch by a number of jobs. Determining which value makes
sense was done empirically.

On a 128-thread threadripper box doing an allmodconfig build, best of
2, *.ko, *.mod.o deleted each time:

    modules per chunk    instances    wall
    -----------------    ---------    ------
                    1        11171    10.22s
                    2         5586     6.72s
                    4         2793     4.97s
                    8         1397     4.26s
                   16          699     4.05s
                   32          350     4.05s
                   64          175     4.07s
                  128           88     4.05s
                  256           44     4.03s
                  512           22     4.18s

Wall time flattens for 16-256 module batches.

A slower/lower core machine will do better with fewer modules-per-batch, a
faster/higher core machine will do better with more modules-per-batch.

Therefore, take the midpoint which works in the most margin in either
direction - 128 modules per batch.

This naturally scales with module count too as the optimum gains are
obtained with higher module count, so fewer batches in this case costs less
overhead.

Each instance holds only its own modules' variables and the top-level one
reads no per-module .cmd files at all, the same rules serve both levels,
and an instance is told its chunk with modfinal-first=<index>.

Only the top-level instance builds .module-common.o, to the chunks it is a
plain prerequisite, so no two instances ever write it.

"make modules" with every *.mod.o and *.ko deleted goes from 28.9s to 15.9s
with clang 22. No-op "make modules" goes from 5.6s to 4.8s, as checking the
22,000 targets is spread over the chunks too.

Whole build, 128-thread Threadripper 9980X, best of N runs:

                                         before   after     delta
                                         -------------------------------
  x86 allmodconfig, no-op make, gcc         2.3s     1.4s    -0.85s (-38%)
  x86 allmodconfig, no-op make, clang       2.8s     1.8s    -0.94s (-34%)
  x86 allmodconfig, clean, gcc            306.6s   294.1s     -12.6s (-4%)
  x86 allmodconfig, clean, clang          290.2s   283.9s     -6.4s (-2%)

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 scripts/Makefile.modfinal | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 75e9effdf02c..4d5e6e1a0ff9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -13,9 +13,30 @@ include $(srctree)/scripts/Makefile.lib
 # find all modules listed in modules.order
 modules := $(call read-file, modules.order)
 
+modfinal-chunk-size := 128
+
+ifdef modfinal-first
+
+# this instance handles the chunk of modules.order starting at $(modfinal-first)
+modules := $(wordlist $(modfinal-first), $(words $(modules)), $(modules))
+modules := $(wordlist 1, $(modfinal-chunk-size), $(modules))
+
 __modfinal: $(modules:%.o=%.ko)
 	@:
 
+else
+
+modfinal-chunks := $(addprefix chunk-, $(shell seq 1 $(modfinal-chunk-size) $(words $(modules))))
+
+PHONY += $(modfinal-chunks)
+$(modfinal-chunks): .module-common.o
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal modfinal-first=$(@:chunk-%=%)
+
+__modfinal: $(modfinal-chunks)
+	@:
+
+endif
+
 # modname and part-of-module are set to make c_flags define proper module flags
 modname = $(notdir $(@:.mod.o=))
 part-of-module = y
@@ -29,8 +50,11 @@ quiet_cmd_as_mod_o = AS [M]  $@
 %.mod.o: %.mod.S FORCE
 	$(call if_changed,as_mod_o)
 
+# Built by the top-level instance alone, the chunks take it as a plain file.
+ifndef modfinal-first
 .module-common.o: $(srctree)/scripts/module-common.c FORCE
 	$(call if_changed_rule,cc_o_c)
+endif
 
 ifneq ($(WARN_ON_UNUSED_TRACEPOINTS),)
 cmd_check_tracepoint = $(objtree)/scripts/tracepoint-update --module $<;
@@ -58,7 +82,11 @@ ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 endif
 	+$(call cmd,check_tracepoint)
 
-targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
+ifdef modfinal-first
+targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
+else
+targets += .module-common.o
+endif
 
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------

-- 
2.56.1

