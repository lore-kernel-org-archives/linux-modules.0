Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4F185951
	for <linux-modules@vger.kernel.org>; Fri, 23 Aug 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423299; cv=none; b=psiHqwRWMLmKjMqtc4u5Cs2cqxZdYsPhf+ztP0ftagE3pS28ucFtUKAYbkR7/IzsfwVOjt9fyqVu0yx0IKwLglcDiqeBWR5BPz/YHqzZwBacqb20YPGeQ2pgu/5IQFZlVH0+QMqFke9KzSVlflMTDOh+/EI7lqcOr4PGrLdBHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423299; c=relaxed/simple;
	bh=SnDFux/fhi3cwvYLU3j8zed/L+ZbGvV9LI0yhVV3hWw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=PkpHChsy+ogedtui+weCzwsSuxEFeXI80w/psobsF8d7IcNQcXCCVGHFeVfk+fstkO++CQQdAJ385WBqzobGVIVosPihZvyQN595uk9UXCy5y1j3N9khhGy4+uYzSClEj+WwlX4P61t9EDahnL/0+Gw9NqdUkPZdUlBc4n5n3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=keKFFM17; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="keKFFM17"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240823142815euoutp0136ec29c479ee3a7bcc6f26b592c06e0f~uYdnRH5Zm3058630586euoutp01L
	for <linux-modules@vger.kernel.org>; Fri, 23 Aug 2024 14:28:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240823142815euoutp0136ec29c479ee3a7bcc6f26b592c06e0f~uYdnRH5Zm3058630586euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724423295;
	bh=HD4eE7vwtLj4VX61TxbKyJfyLQL/SBGyzduGVy2uWOA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=keKFFM17vPqDm1eaw8xYE7JRG0/l59OhO0usm1UEVctkMZbkFUDXYyVseLKt3VhJn
	 78yq5sW3Rh/P46gTKlg8HJi6OcfhXQKIXu8qOMxf6tvVjSy9MbRYjy7ORxKtsUjMsF
	 JPgzsmO86O/jDQLV7PJAxhRSVN3Hzd3IegYu1kjk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240823142815eucas1p10a765bab122ef20b1b7f33758bf4a83a~uYdnFuhKi0068100681eucas1p16;
	Fri, 23 Aug 2024 14:28:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C9.38.09875.F7C98C66; Fri, 23
	Aug 2024 15:28:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240823142814eucas1p205260ffd9afdfe778edd673f4a2ddb66~uYdmq6Iwc1349113491eucas1p2G;
	Fri, 23 Aug 2024 14:28:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240823142814eusmtrp10cb34f9fdd7693a767bc4c24984ae978~uYdmqHIob1695816958eusmtrp1l;
	Fri, 23 Aug 2024 14:28:14 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-b1-66c89c7f8fc9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.78.08810.E7C98C66; Fri, 23
	Aug 2024 15:28:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240823142814eusmtip2d67332f8577a3ad73bb9df0292d9e1dd~uYdmX3zj12278322783eusmtip2o;
	Fri, 23 Aug 2024 14:28:14 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 23 Aug 2024 15:28:14 +0100
Date: Fri, 23 Aug 2024 16:28:13 +0200
From: Daniel Gomez <da.gomez@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<petr.pavlu@suse.com>, <samitolvanen@google.com>, <kris.van.hees@oracle.com>
Subject: Re: [PATCH] MAINTAINERS: scale modules with more reviewers
Message-ID: <20240823142813.5s3xjaqftznddwje@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240821174021.2371547-1-mcgrof@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned36OSfSDHqW8Fic//qX2eLyrjls
	Fg2zv7Na3JjwlNFi6Zd3zBZLV7xldWDzWLCp1GPTqk42j49Pb7F4rN9ylcXj8ya5ANYoLpuU
	1JzMstQifbsEroz7f74yFTzmrOjs2sTUwPiKvYuRk0NCwERix+pbLF2MXBxCAisYJb59fscM
	4XxhlDhx5RgrhPOZUeLYjc9sMC0vty9khEgsZ5Q41drKCFc1e/IWqP7NjBJfWzrAtrAIqEp8
	WnyHBcRmE9CU2HdyE1hcREBDYt+EXiaQBmaByYwSvTcWgxUJCzhLnHz5CWgsBwevgLfE98PG
	IGFeAUGJkzOfgJUwC+hILNj9iQ2khFlAWmL5Pw6QMKeApUTzz+nMEJcqSsyYuJIFwq6VOLXl
	FtgqCYEnHBKXm/qgEi4Sk1fugLKFJV4d3wINGRmJ05N7oOLpEkvWzYKyCyT23J7FCrJXQsBa
	ou9MDkTYUWLLzG9MEGE+iRtvBSGu5JOYtA3kHJAwr0RHmxBEtZrE6ntvWCYwKs9C8tcsJH/N
	QvhrASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMD0cvrf8S87GJe/+qh3iJGJg/EQ
	owQHs5IIb9K9o2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwc
	nFINTBu9K3UCbuX1LWhZebj06BaZsCCesD/R/Ze3BU1kvc0oOz289ecpBoHLq/tS1oQxb9sm
	zfj/p4jI+lNT2wRl5bZ/c5n2NjE0wrVn7UapY1sSPxk/tqs5c9c2iHVChMMHe5Z26Rq50OKo
	NaGNwnlcm9rfqp9Peq5VLynZun8nlybXhGa96YvfKM2r21A/69HSM8Irz+d2SdZsnzC9PnP7
	F1m928IK8+19lrlnXfzz57J0/LOsyx7c0z9dEkyW1X3laCyTVyxjW7R/bUT+qSKR18ZtWpce
	bgm5fYevOC9lQmTkhJ8Gtiv/+Vgk66kbsT/7I9Z5/FKMa0XeF+1m41u+VdZRXnbh/huvn5oi
	urxXiaU4I9FQi7moOBEAf3vfFp4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7p1c06kGXzfqWFx/utfZovLu+aw
	WTTM/s5qcWPCU0aLpV/eMVssXfGW1YHNY8GmUo9NqzrZPD4+vcXisX7LVRaPz5vkAlij9GyK
	8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLu//nKVPCY
	s6KzaxNTA+Mr9i5GTg4JAROJl9sXMnYxcnEICSxllNh74gUzREJGYuOXq6wQtrDEn2tdbBBF
	Hxkl1t25zQaSEBLYzCgx6asxiM0ioCrxafEdFhCbTUBTYt/JTWAbRAQ0JPZN6GUCaWYWmMwo
	0XtjMViRsICzxMmXn4BWc3DwCnhLfD9sDLGgh1Gic0I/I0gNr4CgxMmZT8DqmQV0JBbs/sQG
	Us8sIC2x/B8HSJhTwFKi+ed0qKMVJWZMXMkCYddKfP77jHECo/AsJJNmIZk0C2HSAkbmVYwi
	qaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFxtu3Yz807GOe9+qh3iJGJg/EQowQHs5IIb9K9o2lC
	vCmJlVWpRfnxRaU5qcWHGE2BQTGRWUo0OR8Y6Xkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLp
	iSWp2ampBalFMH1MHJxSDUxtmjclY95XarwWEDiyKd1QQ2xG0gmduBnb6+frTYhYcUdZ8HqY
	9DLZtJurouRz6tf8XV1X9YxD78i5Wd/P2CpWngwPbtljUyO+/uqfCxXn/+yzPdU/d0/8Er6z
	EWvfzVmmddln1ru2H+ravx/cKZiXtvzIrsMy6zxqytWU85bvPD9tu0fUhr+8qwLWRN8VD6id
	sPigrlrCfT4jtZ7nDHWT0oVUn8Tc+qyg7PP/aNCm7Oot9UUb1j+wC5MMCpYqlg79KrVTqjiX
	fWayECPXg3/MH090L/ymF2poXrQr86Vx3jpu3nvGx2dsnOGz5IRtj+as/9/tNl53P5FYfJWr
	JkNRPuvapoN7KjT3zX6mWSusxFKckWioxVxUnAgALnom2DwDAAA=
X-CMS-MailID: 20240823142814eucas1p205260ffd9afdfe778edd673f4a2ddb66
X-Msg-Generator: CA
X-RootMTR: 20240821174031eucas1p227ee9e3d67c1b52aca8603f73e7d30dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240821174031eucas1p227ee9e3d67c1b52aca8603f73e7d30dc
References: <CGME20240821174031eucas1p227ee9e3d67c1b52aca8603f73e7d30dc@eucas1p2.samsung.com>
	<20240821174021.2371547-1-mcgrof@kernel.org>

On Wed, Aug 21, 2024 at 10:40:21AM -0700, Luis Chamberlain wrote:
> We're looking to add Rust module support, and I don't speak
> Rust yet. The compromise was reached that in order to scale we'd
> get volunteers committed from the Rust community willing to review
> both Rust and C code for modules so we can ensure we get proper
> reviews for both parts of the code and so that we can scale.
> 
> Add those who have stepped up to help.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Acked-by: Daniel Gomez <da.gomez@samsung.com>

Daniel

> 
> First order of business, please help review Kris Van Hees's patches with
> Rust in mind!
> 
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..7e2cf251427d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15454,6 +15454,9 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
>  
>  MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
> +R:	Petr Pavlu <petr.pavlu@suse.com>
> +R:	Sami Tolvanen <samitolvanen@google.com>
> +R:	Daniel Gomez <da.gomez@samsung.com>
>  L:	linux-modules@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> -- 
> 2.43.0
> 
