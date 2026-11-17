Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=116.130.217.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880718;
	b=hOlG+NqE0eWEvZH6Bw1k817v8Ue9anOh70hLGOiIPIMGjJD72WkPCQk/MW0bcfD1ShMG
	 jKRiptcQIL9xxeJW/4h4lJ72d91/KH8VZJJzBJeGXfIAKIu2QAovu5cu5/venNOXsh4go
	 wN/1RhFIu4gjNAKAc/QL3e9aD8cSNBsdypM9j5yHANV3L1pED1G/UI4dg3nL9lzjXz+Fx
	 SV2zomdVZYOhWFPEYliJ5B7l+evNKG4LjH49QtQ2EOj/MX5Gqh9kQef0sJ0WyaB+34AHn
	 YY64NliRKMR4pP02CFI2cCR6d7lF8Bgel2jGnxpc2iSkKzzVgUXFRZz3ko3O3/2dv7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880718;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Message-ID:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Sohu-Gateway:
	 X-Sohu-Antispam-Language:X-Sohu-Antispam-Score;
	bh=b7ao7xZkMPE1NdDNlwsTBMweTfWb8WQp5pO29sWqgIE=;
	b=jHjPDvJWu13RJdD5oV/ftkliPNvQ80FyBxzbQoGl0zVWleFamEYDipO7hb1CDtiRfsBh
	 8ocS29DyPl0pec+Ch8c308IfGimk1Yvr8tuG/gqa+EBUUaD6plPN6AUHNuWchmVAvaupf
	 mMsnoW0bcJhsNEFLOODzVmQKSjJPgvQqiMz0726rdxwYFGycQIEWogBDQnk1/OGSs7jJL
	 bKN051kM1sWm8tg0yBz2nR19r38gcrayb3SDQkiCb32apIGX3HAzDvaqNgu20lLQBw7to
	 T/SPhXE7Il8YVbPmcO0IjdRDJH4UnsG7hXKufljYrXXhb32xdOOC3MoqevyOZfR+56g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sohu.com;
	spf=pass smtp.mailfrom=sohu.com;
	dkim=pass header.d=sohu.com header.i=@sohu.com header.a=rsa-sha256 header.s=mail header.b=ESWkxOAm;
	arc=none smtp.remote-ip=116.130.217.65
Received: from smtp217-65.mail.sohu.com (smtp217-65.mail.sohu.com [116.130.217.65])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363B606A32C
	for <linux-modules@vger.kernel.org>; Tue, 17 Nov 2026 01:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1363B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sohu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sohu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sohu.com header.i=@sohu.com header.a=rsa-sha256 header.s=mail header.b=ESWkxOAm
Received: from ed522b6a8414 (unknown [144.255.82.85])
	by smtp217-65.mail.sohu.com (Postfix) with ESMTPA id 4jT7Dg09hzz6vF8
	for <linux-modules@vger.kernel.org>; Tue, 17 Nov 2026 09:58:26 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sohu.com; s=mail;
	t=1794880707; bh=b7ao7xZkMPE1NdDNlwsTBMweTfWb8WQp5pO29sWqgIE=;
	h=Date:From:To:Subject:From;
	b=ESWkxOAmRCKKk8MXNeTlYocirL06j976T/VKdz3gQW88sQsm6/vaok/GKDyf5W922
	 zLeVIs4BNNpCoG/MKWDazgrpRTfh5Jk3WRA1k1iww9USHhlAGKPGV6CYdMJ631HjAT
	 4aFlAA2+Qco/YDpvGUHgRG3KpFjbwE8lJKXRSj8I=
Date: Tue, 17 Nov 2026 09:58:26 +0800 (CST)
From: 13465686061@sohu.com
To: linux-modules@vger.kernel.org
Message-ID: <1653995939.2031.1794880706092@ed522b6a8414>
Subject: Multi-language support proposal for kmod project documentation
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Sohu-Gateway: 1
X-Sohu-Antispam-Language: 0
X-Sohu-Antispam-Score: 0.01

hello kmod.

 I noticed that the kmod-project project you maintain provides an HTML format documentation website through GitHub Pages ( https://github.com/kmod-project/kmod-project.github.io ), aimed at the Linux kernel developer community, this type of technical documentation has a natural need for international dissemination of multi-language support.

 I'm developing an open source JS translation plug-in translate.js , supports adding multi-language switching function to static web pages with one click without changing the HTML structure. It is completely free and open source, and the MIT license is compatible with your project positioning. At present, many open source projects have been directly integrated and used through GitHub. For example, adding a small amount of scripts to the documentation page can take effect.

 If you think it can help kmod's document access experience, you are welcome to search xnx3/translate directly on GitHub to view the project details, and click a Star to support the development of the open source ecosystem.


----------
Email management powered by https://github.com/xnx3/bizbot
