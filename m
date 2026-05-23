Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4F1DF748
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779521404; cv=none; b=uz9Zwr3rqLlNNVPwTU0amXo00BzlOWB9NfrPAVQVfES9cQ2hyfjcQu5eC1ss+qZQtFnTnd+FpHFpShY9DsT8AlUM3bWDLrAugnajM2m0zhOoSlQ7pZGEerFcXJNSIqGwoUo7LNZZN+S5CBRl8kd5btJTlqF7QLZaTJelE3PlQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779521404; c=relaxed/simple;
	bh=9kBCj0G5t6zmK2RnF50fWD2rSOMXPGn054WBvI9HNro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PYbT5UvTafOsGgj9EVa/TG2aANCqcRtR042kO+SycDZ6gjjua2UChqrEOeYZBwVyJ3AeT5wgPIcIdo4hwy+qQ4AoBMvUvcE2wnETwvtScSSahBFxrEe5p7WSu7EZk5d8WYRFPzEO0ma2ZIDbji09fHKzkgvK9CoEH2Lo4CmAShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOzs4W7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOzs4W7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B41C1F00A3A;
	Sat, 23 May 2026 07:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779521403;
	bh=ayg4L3XZAS+bk1kqRjsiyVRWddIUxEpiDZEmAYhJLSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOzs4W7YViLNDby6fapT0AZGGcthm3l1xBtw4EdRzYwi+srk5EGm6jMckia0+L9Ob
	 lzw9xqTpNv5MFa7v0ZVFZvXGsURV125NEqQjVswzWW71AVierkGadgD68EOILswmtb
	 BUvVu31xRMnV/5k2GffXfUtjhEDLCLZ+TYxHC9K+SZHkXjf0BqoWYQdhMioguPPOh+
	 7FVv8YeKyrOxnSZVG/656sziiu1JT/UwLmGjEw26WicGxVuPMjI3j42iIqxqyU1BU3
	 HmmmQxW/eZa0yTpC092EUFodNZ+ASpW+4rSHYxsduJN4SP1mC9gM+A8GK0oi5cH0me
	 dJqctoXbJu9gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/24] dyndbg: reduce verbose/debug clutter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260523-dd-maint-2-v2-13-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-13-b937312aa083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 07:30:02 +0000
Message-Id: <20260523073003.2B41C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch implementation directly contradicts the stated intent =
in the commit message regarding which log lines are dropped from the 3rd st=
anza.
--

commit 508361dc136fe2a26caa1e30ec9b645bd4c49e81
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: reduce verbose/debug clutter

This patch aims to reduce excessive logging in dynamic debug, specifically
shrinking and dropping several verbose messages during query processing and
module addition.

>  - shrinks 3 lines of 2nd stanza to single line
>  - drops 1st 2 lines of 3rd stanza
>    3rd line is like 1st, with result, not procedure.
>    2nd line is just status, retold in 4th, with more info.
>=20
> New output:
>=20
>  dyndbg: query 0: "class DRM_UT_CORE +p"
>  dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
>  dyndbg: op=3D'+' flags=3D0x1 maskp=3D0xffffffff
>  dyndbg: processed 1 queries, with 0 matches, 0 errs

[Severity: Medium]
Does this commit message accurately reflect the changes made in the code?

The commit message states the intent is to drop the first two lines of the =
3rd
stanza (the "parsed" and "no matches" logs) while keeping the third line
("no-match"/"applied") since it shows the result rather than the procedure.

However, looking at the code changes below, the implementation drops the se=
cond
and third lines but appears to keep the first line (the "parsed" log printed
from ddebug_parse_query() right before ddebug_change() is called). This see=
ms
to result in keeping the procedure log and dropping the result log, reversi=
ng
the stated intent.

Additionally, should the "New output" example in the commit message be upda=
ted
to include the "parsed" log line that is still printed?

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 6d9dbeb68ae83..dfed3725aa44b 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -277,9 +277,6 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>  	}
>  	mutex_unlock(&ddebug_lock);
> =20
> -	if (!nfound && verbose)
> -		pr_info("no matches for query\n");
> -
>  	return nfound;
>  }

[ ... ]

> @@ -570,10 +565,7 @@ static int ddebug_exec_query(char *query_string, con=
st char *modname)
>  		return -EINVAL;
>  	}
>  	/* actually go and implement the change */
> -	nfound =3D ddebug_change(&query, &modifiers);
> -	vpr_info_dq(&query, nfound ? "applied" : "no-match");
> -
> -	return nfound;
> +	return ddebug_change(&query, &modifiers);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-dd-maint-2=
-v2-0-b937312aa083@gmail.com?part=3D13
