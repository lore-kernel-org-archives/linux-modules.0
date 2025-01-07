Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5711EC012
	for <linux-modules@vger.kernel.org>; Tue,  7 Jan 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255362; cv=none; b=MltNH1Cw+K02Nwa8i0Qh/VVU9toomgZx8DxpLS7A+wpx+CzOPLinX716hL1i4Lx+7pS8sHh81HvQtxJ+yAWib9oYT6InVYoHzZqAy20/nskEWNSfokO6NqI2K/9LFzUAtqxgHaZLaqbkyqyUc8E6ptk44KIaNFdL/ARHqs2PzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255362; c=relaxed/simple;
	bh=jCKA14jAdMLukE9hbjtwtVsHqD7XRQxyYxSyx40LAYs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=uCHzXoVPa1uxxRr9kfnz0SR46ZziAMaR08IIjc73InRqCgmJaIPUD8Ft7LF9wSQpZqZ7xLoQJGfvvvpuCZBq6NamD+ULSodv3tkeIMbhuvXqhA7+8H1JHlZNH55+4T2fjwZu37lAWagqUdupcgKJbzBqI1h89XoPXalxkrWVTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L8ipS0N6; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L8ipS0N6"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250107130011euoutp02988a5512bf6a0b1d61f04c67bc080198~Yao1hNryU2262522625euoutp029
	for <linux-modules@vger.kernel.org>; Tue,  7 Jan 2025 13:00:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250107130011euoutp02988a5512bf6a0b1d61f04c67bc080198~Yao1hNryU2262522625euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736254811;
	bh=7ldK6dNcZzHpOULmajqZfkl7838Z8XKw07ksv9JKsJo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=L8ipS0N63bZUR3vufgH8hbYA5KqugIG1CboPl3h4xeo1yAVB2zhm2ZJ+NTGMPHgBq
	 FXol5evbR+kSZ0AFq1rgHodMol2cdN9tFJCsKuZDvuiWyijoDNzQcbdBzq8z9ECDGC
	 A+v7AzjHUXuJJEM6kd8IeR9zuwINHy6bgP2KhVsg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250107130011eucas1p135d81e59b3ef150364e8eb6bfe7dd2fb~Yao1SBoEx0893608936eucas1p1Q;
	Tue,  7 Jan 2025 13:00:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.3F.20397.B552D776; Tue,  7
	Jan 2025 13:00:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250107130011eucas1p13fba0f5a7b3321a6b56c639da94b0807~Yao03LnvM3035230352eucas1p1j;
	Tue,  7 Jan 2025 13:00:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250107130011eusmtrp1552f0433f53834b23f805d7a1a2a5fcd~Yao0yPXW31906019060eusmtrp1V;
	Tue,  7 Jan 2025 13:00:11 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-8b-677d255bde0b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.79.19920.A552D776; Tue,  7
	Jan 2025 13:00:10 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250107130010eusmtip11265951a09a4c1befa35696f1f2888df~Yao0YTa5-3182131821eusmtip1c;
	Tue,  7 Jan 2025 13:00:10 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id
	15.0.1497.48; Tue, 7 Jan 2025 13:00:09 +0000
Date: Tue, 7 Jan 2025 14:00:08 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Kees Cook <kees@kernel.org>
CC: Petr Pavlu <petr.pavlu@suse.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Luis Chamberlain <mcgrof@kernel.org>, Sami
	Tolvanen <samitolvanen@google.com>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Mike
	Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
Message-ID: <20250107130008.nieaxsjpptwbwe5d@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202501061610.203636A9C@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3e57n7p7OLk/H+JJE7qIQeZkn75R2ExbzssXG0bPr7U7dizhO
	Z2FqNEKli9pId5LOU+kiabe6FEozRvM+77siXVo2xfWcl/8+38/L7/v5bj8SFxfyxpHxKi2j
	VsmTAvhC4rqjv23GFqlBMcvxdAL9LPuDgL7a2cajH94o4NNGUx+PfnLiHaKLXV043VBejdHF
	5k4eXcGewZd5yXqftmKyIlYnYy9n8GVdra0CWXnlI0LWw06I5scIF8UySfG7GfXMJduFcdaW
	jyjZ5r0nPVNmRNbhmciLBGoumK9VY5lISIopM4JrNdU4N7gQ2AtsBDf0IGhztfH/RG4XtvM5
	oQTBlawMwV9XVdUzT6QCwUlb7W8bSRKUBEodwe40nwqCumZW4MajKH+wnXcN7cOpCgyeG88S
	bmEklQTOcxcxNxZRUVBeWsznsA80n3075MGp6VB089vQ+zjlCyUDpJv2okLgkcXkaToJ8k5a
	CA4boMxxb6goUIMkdDy2YJwQAS8vlAo4PBI+N1V68Hi4e+qYJ5wI9/tqEYe1MPD1h4dfCINl
	zz38cmhtYDF3H6C84UmnD1fTG7Kv5+IcLYKjR8ScOxBKXziJE2hy/n+H5f93WP6/w4oQfhmN
	YXQapYLRzFExqSEauVKjUylCdu5Ssuj3H7o70NRrQ+bP3SF2hJHIjoDEA0aJwvwMCrEoVr5X
	z6h3bVPrkhiNHfmSRMAYkTTWnxFTCrmWSWSYZEb9R8VIr3FGbIXVNAwsAuGqlpaG6a5G6x3n
	Pt2XGwdORRriqpiIaTWBdUeRX8zrj+vICF/l7DRWmdBv/pYyz/94b3xdhkk+adryw/WNKz80
	lb0/xETmhgU96E4JfRdWc3DZlPQHM65Ejx5RKO897bu5o0af9RNFO/MerjVuWjO7/tKUtxJq
	YXj5xfSfqX0LUgraewRjt6KEjJj9ZFhj195203praE7RYmlPrVTpnPqKZ07+nvJ68o7R4aBP
	zHPecnQ3Zbq+1m/I8TMsTlshSfCvlAj9NirZQ2lSe+O2T1u12onmZEu26nyLPrVWpc9ZR1xd
	PXdQ3Szrlwa9KVgqWT+/PyrY1XGGCA8gNHHy0GBcrZH/Ampk+BuyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7pRqrXpBm9Om1vcmfSc3WLd2/Os
	Fpd3zWGzaJj9ndXixoSnjBZLv7xjtjiyfjuTxdIVb1ktNm+ayuzA6fH15jkmjwWbSj02repk
	83h37hy7x/otV1k8Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
	t7NJSc3JLEst0rdL0MvYcOoFY8EOvormLo8Gxg3cXYycHBICJhL7519k62Lk4hASWMoosX3p
	NxaIhIzExi9XWSFsYYk/17rYQGwhgY+MEgsvikE0bGaUuH91JVADBweLgIrE6mNaIDVsApoS
	+05uYgexRQTkJXbM+8IMUs8ssJlJ4urkiWBDhQVyJN7MXcIEYvMKeEusX70U6ooXjBInJ59k
	h0gISpyc+QTsImYBHYkFuz+xgSxjFpCWWP6PAyTMKaAncXXlbDaIQxUlZkxcCfVArcSr+7sZ
	JzAKz0IyaRaSSbMQJi1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGI3bjv3cvINx3quP
	eocYmTgYDzFKcDArifBaytamC/GmJFZWpRblxxeV5qQWH2I0BQbFRGYp0eR8YDrIK4k3NDMw
	NTQxszQwtTQzVhLndbt8Pk1IID2xJDU7NbUgtQimj4mDU6qBaXfIo0DpMwzz/SqXivj7ewd2
	JvxeclrjYdv0dS6NM3d+sSq/UTDF6Hz0/t8b3lxp8O7WEbGyfFWjcfzEntQvl9wyLA3/qm09
	vslt28SgDJW6U0HJqzZ5cPxvfXxrspF94qpKfUObtsyuNS5NbvcX8xZ6XZ695mzRurc9n7S1
	fn8Uthc8ci5bT/dswrvcneXvkoyn7fprzLvG/9gB+8VNi9n/yCy9ln7EOXOxycL6XK/ZkxdU
	tFvcCRALUs6Z0Nje2yd3yb/e9O/hs2eeZU0OS24ocojSK7UTi9sSfuZEl3lU6PYZy46L9ZRK
	lkzd42Pp+yFy68q1gaWz07bNrJwz922r5g7xhLM7JOpPNrlzK7EUZyQaajEXFScCABIj92tP
	AwAA
X-CMS-MailID: 20250107130011eucas1p13fba0f5a7b3321a6b56c639da94b0807
X-Msg-Generator: CA
X-RootMTR: 20250107001338eucas1p24b8d0a4f5076e74d435a9c6bf73c82aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250107001338eucas1p24b8d0a4f5076e74d435a9c6bf73c82aa
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
	<f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
	<CGME20250107001338eucas1p24b8d0a4f5076e74d435a9c6bf73c82aa@eucas1p2.samsung.com>
	<202501061610.203636A9C@keescook>

On Mon, Jan 06, 2025 at 04:13:29PM -0800, Kees Cook wrote:
> On Fri, Jan 03, 2025 at 05:13:32PM +0100, Petr Pavlu wrote:
> > On 12/5/24 20:46, Christophe Leroy wrote:
> > > This series reworks module loading to avoid leaving the module in a
> > > stale state when protecting ro_after_init section fails.
> > > 
> > > Once module init has succeded it is too late to cancel loading.
> 
> Is there at least a big WARN about the ro failing? That should let more
> sensitive system owners react to the situation if it looks like an
> active attack on memory protections.

Yes, there is. But I think only the first time a module fails. IIUC,
any subsequent modules failing will not warn anything, is that right?
However, I think this should suffice to know a system is vulnerable but
will not know the full list of the actual vulnerable modules.

> 
> (And maybe we should set a TAINT flag, but perhaps this is too specific
> a failure mode for that?)
> 
> Also, why is it too late to cancel? Can we set the module to the
> "Unloading" state to stop any dependent modules from loading on top of
> it, and then request it unload?

I think Luis summarized it here [1]. Quoting him from that thread:

	Sadly there are a few issues with trying to get to call mod->exit():
	
	- We should try try_stop_module()  and that can fail
	- source_list may not be empty and that would block removal
	- mod->exit may not exist

https://lore.kernel.org/all/Zuv0nmFblHUwuT8v@bombadil.infradead.org/

Module loading goes from UNFORMED to LIVE during the initialization.
And once it's LIVE we do the ro_after_init memory protection. I'm not
sure if an intermediate stage can be added so ro_after_init is performed
and module is unloaded when this fails? I guess init does not necessary
mean LIVE.

Daniel

> 
> -- 
> Kees Cook
