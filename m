Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AE375F6C
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478509; cv=none; b=PNSLnxrzKeGGZhUp4gC+EhpvgsAvKWicS4/HZP6ghDiB4cf113zZ9F7lDSMfMONkrQ9Irk2osOUPK6OWJBZO8b7vBDDPzGgPptbMnIJ9TTtuWRzWzRybkBOirnE4xfjZRGYNq9TpXeoTCYbX/4XX1xZ3aQXzSAYR36oJOzbylz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478509; c=relaxed/simple;
	bh=nGe2XgekSJGt9bn2fUazHU1h/nIv6fQirnMw0M6iTpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l0yWGVOLcECRBRIl2bjqoLxSZlP3NTZbS5/tC7VYSOhijhElSCFJVokgx3xOl2LEWBy2gVmWpWGKgZ5RP5eZiughqIxDCOB1wukPSUBbsHhzAhrPJ/IefIjVKE3RD619e+zW5T3s3cEhVzDyVFyXtHmR3vUoGFhEuoAuWq1Qh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+1vuZg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+1vuZg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777E71F000E9;
	Wed,  8 Jul 2026 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478507;
	bh=CYYcLX6j+6rkzw6OOapXwFbq6F4yyNdKuEWGnkImX58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+1vuZg5oPDCKOgGqnFSQ3njuCnRK0Vda/gXu8rtSDs7N4BCrxe0xqH/7yGWMwbI8
	 tWFLEw/hu1oegLdWV3qIOyHL33RQ2zVmz17/6bbJJNSjPzQ8KR/kZtmKy9WzZX9yKR
	 s0yOcy3BMoJkT40xSypM/6vzFfzTd9E2Q2tlEKrX0625UydOIUVsDkrpb8IuEH2sY4
	 fnxGU4Wm4sr6vRigNA/vqb2tuww2gYSGJr42aALDwnf5YvXIasTMZ1dzGDXmLFkqPn
	 HBNZvUn5hESYeB2ip/BExcfXRWtRnlX2D3DHj+hZ/4gQ9/NcE4csJ7P0G9g/NxQGTS
	 dy/vYJV7JBDDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/24] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260707-dd-maint-2-v6-23-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-23-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:41:47 +0000
Message-Id: <20260708024147.777E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] API Consistency / Build Breakage Trap: Dynamic debug wrappers evalu=
ate to int when enabled but void when disabled
--

--- Patch [23]: [PATCH v6 23/24] dyndbg: change __dynamic_func_call_cls* ma=
cros into expressions ---
commit 003daac5c2950ded79f06209b5d0ab4dfeb11a5a
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: change __dynamic_func_call_cls* macros into expressions

This patch modifies the __dynamic_func_call_cls* macros to use statement
expressions instead of do-while loops, allowing them to return 0. It also
updates the fallback dynamic_hex_dump() macro to ensure it behaves
consistently by returning 0, allowing debug macros to be used inside
conditional expressions.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 355f2cb117334..8822f9a3605f6 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -238,24 +238,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
>   * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
>   */
> -#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
> +#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
>  	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
>  	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
>  		func(&id, ##__VA_ARGS__);			\
>  		__dynamic_dump_stack(id);			\
>  	}							\
> -} while (0)
> +	0; /* match no_printk return value */			\
> +})

[Severity: Low]
Does this introduce a build breakage trap for configurations where
CONFIG_DYNAMIC_DEBUG is disabled?

While this macro now evaluates to an int (0) when enabled, the fallback
macros used when dynamic debug is disabled often evaluate to void.

For example, dev_dbg() falls back to dev_no_printk(), which evaluates to vo=
id:

include/linux/dev_printk.h:
#define dev_no_printk(level, dev, fmt, ...) 				\
	({								\
		if (0)							\
			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
	})

Similarly, drm_dbg() falls back to the __drm_dev_dbg() function which retur=
ns
void, and print_hex_dump_debug() falls back to a void inline function.

If a driver developer uses these macros in a boolean expression (such as
if (cond && dev_dbg(...))), it will compile successfully during development
with CONFIG_DYNAMIC_DEBUG enabled, but will break the build with an invalid
operands to binary && error when compiled without dynamic debugging.

Could the fallback macros be updated to consistently return 0 as well to
prevent this mismatch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D23
