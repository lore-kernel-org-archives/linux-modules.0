Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228378F2F
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633109; cv=none; b=FfF7f04mFHbT0d1hEETufL8dSuHEm5Z345VQRIClYM5vzJ7RNuJ7Q86w6XMX1ecuG75xGgL6vN4MF+HP+wcuVC1L0QEhaK16IOD/0oXxpJ0DaT7eiGDCiGbQkMf2A7l7LIeX4OT6BMZKq1xrSd8K5SaDYGUfPjigHz4ZRulCAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633109; c=relaxed/simple;
	bh=MycTT0DMxxvVrxv/OLnx3s0/BJ+ywrLV8WDZTDxjgG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FIko4M/mpXLxwsrLhpnu6Q39WQhXjiHXX6+zrPiKwBTXxMWxuYdp8R71YbnXLoGWtN+CCVR6Md90XNKi+yHCx1a6iN6ngwlJHYpPURSSHk5ll23uHbPWO6oAnbuY8FlPdxONoI4WV1WViFcsq1kwwIJVJEzVF4yH9vFk1tAMb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V050tsDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V050tsDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2661F00A3A;
	Sat,  5 Sep 2026 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633108;
	bh=pg+hRIuGW51lumXyhEXKouDViUan+wVFXOX3+cROFd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V050tsDS2WCDoh3oPkiLHemSGNdR/ryCJBeuaNrodmSLvmiTL/PT5H1cb9rUoT1+X
	 nVjr54AkC8q3LGt7BPmgGoAiG6lGcFL0Kzt6mQuA3dLzyQ+UqN0E9HE9Pg1TaC4ssL
	 pdQqgLOUq/h0tBQjDnEKPSGYR0kjDe04z64P6k9fEgClQBlr1+ozEj1G6nauc/77G+
	 1ZGCyqISjm6Zo0FnAaopJFVJuXGqk3Qj/GwK2CPyfXHuHzegSrdAhkLXfwjfbyQwlH
	 CcnQgKjwMRy+9K9cu7NMqJUpdLrLxMXGi+ncOIdv8S+EsOJqEeD8yvG7gacP//Ix0m
	 sBiyms1yYFZsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 39/43] dyndbg: Ignore additional arguments from
 pr_fmt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-39-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-39-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:31:48 +0000
Message-Id: <20260905183148.9B2661F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Change pr_debug_ratelimited to pass 'fmt' instead of 'pr_fmt(fmt=
)' to avoid masking the true invocation error via an improper variadic sink=
 in DEFINE_DYNAMIC_DEBUG_METADATA_CLS.
--

commit 6b20b9b19031937bd627698de6352c6bfec6e4f6
Author: Philipp Hahn <phahn-oss@avm.de>

dyndbg: Ignore additional arguments from pr_fmt

This commit alters the DEFINE_DYNAMIC_DEBUG_METADATA_CLS macro to accept and
discard variadic arguments. This is intended to workaround a build error wh=
en
pr_debug_ratelimited is used with a pr_fmt that adds arguments.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index d00605ef651ec..82cde8e6b46cb 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -362,7 +362,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  		dump_stack();					\
>  }
> =20
> -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\

[Severity: Medium]
Does taking variadic arguments here mask the underlying invocation error?

By taking '...' and discarding the extra arguments, the metadata descriptor
for pr_debug_ratelimited() incorrectly stores the prefixed format string
(with unresolved format specifiers like "%s"), while pr_debug() stores the
unprefixed format string.

This inconsistency breaks dynamic debug format queries when a module redefi=
nes
pr_fmt with multiple arguments.

Should pr_debug_ratelimited() in include/linux/printk.h be changed to pass
'fmt' instead of 'pr_fmt(fmt)' to DEFINE_DYNAMIC_DEBUG_METADATA(), similar
to how dev_dbg_ratelimited() handles it, rather than altering the metadata
macro to silently drop arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D39
