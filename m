Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057904;
	b=QumI3xLPDTHwALcfg4fUchLKE7B5ozK/Hv3AYXOQd8cdN8PxOTzYk4UroRjmPEoXDlB7
	 ovYDYC9ie+r/IQe9r7hF2iD7kBTfvdmqVnnLzRBflHVM6+8dst7UyNlrRTqRsyNITwsZp
	 rgkCJl4vzR5xwvNcQSpkpziJ5rRhW1v4T4K14ZqGxh0DR5lcMa3308LaJdE+Noy3IOxxB
	 fqZA3vlYiNXvlKde/jORDn0LMOctreHZPE0mpnyfROxuLISlmPpvcS8Zw5hz4mthMrD90
	 cWR3hCF80qanBg4QzqBGkpgmE0/h0xsFYd+8dOvs3iaQp549oZYUR8IH9sfyyHvoGHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jQRENtiL5agONezGVZU6tJCWCDm7CsZdQvyh/vxneqU=;
	b=XY23jvodIk+v9fdubVKyB0WpD+WTOWnn6jvZlNnRMtJUb/6W+RQbNW3Q6Fo51Dntv/rx
	 XzXriiaauaGVUmmsz3kfh2PNfOLBdOlPZxA70GlpF4oXaC6hFyQatLdPHngiuBVuFhSsh
	 yjgk6B6tlvDKe+0a/4relB+zaoCpISyL28/Sc8slnwFNgrx17ET5Au+F8O3CEyJJpG0E+
	 S614oIeI4ysel+5dI0AYYLbvhFgT5SnNb6w9agakTnNu8qW32Se0hoHmjTXH45SZjC2JB
	 W+n7ksZeEJUQySIjklIBctSerjS/S/0vF5zk1paqAAhJ3hsxcCQ1jE3FJMvuw8WnNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acRMngLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E70606A32E;
	Sat,  7 Nov 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acRMngLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3391F008A1;
	Sat,  7 Nov 2026 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057903;
	bh=jQRENtiL5agONezGVZU6tJCWCDm7CsZdQvyh/vxneqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=acRMngLsQxtJhSgSWBdwtRtR2LCfppWLiZnC+fZGTJ5TnXQDaIoB0Q6zz7IL1AyDP
	 EKinOJvYGfY5Uc8EXcdLZF+NwkRzLGTjhjjmGxYulyMEIC56k2VGVwxTjvOWF0vqLG
	 SLNBuUbUWmZUYfqwUKtN5CAq1Wjo6sc15moN8mh5/egpUgxsbbYelKzEr6c+3ytehZ
	 ltIDPqEah0lP7GQECTgttA3D1bt8P0SMB/aQAAfV2eoMNDt/LKlVkZn7vB1hrEHTj9
	 Dh+NW4vsWOFDfO6FVWjSvLj+ukqOQSVhlEOzB5W+lVeSY6mqHfDgqtzxIMofi4WYcm
	 lj5NlxYx/rZkQ==
Message-ID: <sashiko-outbox-202912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/4] kallsyms: add KUnit tests for lineinfo feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Masahiro
 Yamada" <masahiroy@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, "Richard Weinberger" <richard@nod.at>, "Juergen
 Gross" <jgross@suse.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Greg KH" <gregkh@linuxfoundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>, "Vlastimil Babka" <vbabka@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Randy Dunlap" <rdunlap@infradead.org>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, "Vivian Wang" <wangruikang@iscas.ac.cn>, "Zhen
 Lei" <thunder.leizhen@huawei.com>, "Sami Tolvanen" <samitolvanen@google.com>, linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20261106132432.248387-5-sashal@kernel.org>
References: <20261106132432.248387-1-sashal@kernel.org>
 <20261106132432.248387-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:25:01 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kallsyms: skip_without_module_lineinfo() misses parisc32 .text.*
  sections
--

commit 0acb15a1e169631dad96f85b0c77c16a41dabc41
Author: Sasha Levin <sashal@kernel.org>

kallsyms: add KUnit tests for lineinfo feature

This commit adds a KUnit test module (CONFIG_LINEINFO_KUNIT_TEST) to
verify that the kallsyms lineinfo feature produces source file:line
annotations in stack traces, and exports sprint_backtrace() and
sprint_backtrace_build_id() for KUnit tests.

> diff --git a/lib/tests/lineinfo_kunit.c b/lib/tests/lineinfo_kunit.c
> new file mode 100644
> index 0000000000000..fc1b97ffb5251
> --- /dev/null
> +++ b/lib/tests/lineinfo_kunit.c
> @@ -0,0 +1,1087 @@

[ ... ]

> +/*
> + * When the test is built as a module but CONFIG_KALLSYMS_LINEINFO_MODUL=
ES
> + * is disabled, the test module's own functions have no lineinfo tables,=
 so
> + * every test that expects annotations on local targets must skip rather
> + * than fail.
> + */
> +static void skip_without_module_lineinfo(struct kunit *test)
> +{
> +	if (IS_MODULE(CONFIG_LINEINFO_KUNIT_TEST) &&
> +	    !IS_ENABLED(CONFIG_KALLSYMS_LINEINFO_MODULES))
> +		kunit_skip(test,
> +			   "KALLSYMS_LINEINFO_MODULES disabled; test module has no lineinfo");
> +}

[Severity: Low]
Will all tests that inspect local module functions fail when
CONFIG_LINEINFO_KUNIT_TEST=3Dm is built on 32-bit parisc?

On 32-bit parisc, CONFIG_ARCH_WANTS_MODULES_TEXT_SECTIONS is selected and
KBUILD_CFLAGS_MODULE enables -ffunction-sections, which keeps module
functions in per-function .text.* sections instead of merging them into
.text.  scripts/gen_lineinfo.c places those .text.* sections into
extra_sections[] and drops their DWARF line entries, so local test targets
have no lineinfo even when CONFIG_KALLSYMS_LINEINFO_MODULES is enabled.

Passing -fno-function-sections for the test objects in lib/tests/Makefile
(or checking IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_TEXT_SECTIONS) in
skip_without_module_lineinfo()) would avoid these failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106132432.2483=
87-1-sashal@kernel.org?part=3D4
