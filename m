Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com [220.197.32.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CA7080D
	for <linux-modules@vger.kernel.org>; Wed, 24 Jun 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312906; cv=none; b=NO8/WTW6ovHg7lO5K+QWoj7u5FdZxMLT4OZ1GDphhctU27IiG7RjnsvF6gTkLtf9nk9IEK4ejKMMQ+MWNpChJHbQPLzSRBVtCzaHeUUdUZ0fMK63QKK1jZbBnBPKzsk+appGrr4cGV3XoZaKciVsnq+Ywn6akuRIbFk9C9KKTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312906; c=relaxed/simple;
	bh=pNBx0j7RX9qE/g5hhKLmr/z1yT4BVlKK3Rb/wpYkWIk=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=UqNX0NYnOO/JMvuK0zYL7MsM09gCbFYj8lZbCgbDgFxzCgF1QRi315Aj4l9R5TEFrHK7ouwPb48fzMNhnH9A4Y5W43yjWzHgyxXFfjk9tCn394BdU8MiVuD+RC9mF7gaQn2gCZP3veHz4Nt+5q0Ce20itK2Wep2IymavbAmwntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Eq1OVkDP; arc=none smtp.client-ip=220.197.32.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Eq1OVkDP"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ABYAywAHKlYpydO6zhazLKo0.3.1782310768005.Hmail.220255722@seu.edu.cn>
To: Petr Pavlu  <petr.pavlu@suse.com>
Cc: mcgrof <mcgrof@kernel.org>, "da.gomez" <da.gomez@kernel.org>, 
	samitolvanen <samitolvanen@google.com>, 
	linux-modules <linux-modules@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW9kdWxlOiBhbm5vdGF0ZSBmYWlsZWQtbW9kdWxlIHN0YXRzIGxpc3QgdHJhdmVyc2Fs?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <31db63df-0a81-45db-97de-67bbe1a1be2a@suse.com>
References: <20260621091905.3555074-1-runyu.xiao@seu.edu.cn> <31db63df-0a81-45db-97de-67bbe1a1be2a@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Wed, 24 Jun 2026 22:19:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 24 Jun 2026 22:19:28 +0800 (GMT+08:00)
X-HM-Tid: 0a9ef9fe447902f2kunmd01325314c29
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5DZd03xfWxKJ5+5n10A36+gYygBUjfIFA2NppH9Q3clqB7ZxgV
	UJHepP4Ay/LXNvs3GA8581R79dvELcl6vOQes=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxlMVh5JTEJNTENPSB5LTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOTkhVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Eq1OVkDP/jhAQESZoBZI3Qb6KHao4CjD7lSE7iCGBJNADNV/Ph/otcP3vDHnY+zbI3EElfCeo775Am0/rlFE3lYyZUTNSDskSy4kF2q3mNoviAkHnqphnP9Mw+nywGx4Ppd4Rpy/PuuqZjW6ZBQ1vvLilzNUCdXDuQu9NrT2FFE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=pNBx0j7RX9qE/g5hhKLmr/z1yT4BVlKK3Rb/wpYkWIk=;
	h=date:mime-version:subject:message-id:from;

T24gNi8yNC8yNiwgUGV0ciBQYXZsdSB3cm90ZToKJmd0OyBUaGUgc2FtZSBmaXggd2FzIHBvc3Rl
ZCBwcmV2aW91c2x5IGluOgomZ3Q7IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1vZHVs
ZXMvZTR6YTI2bjNqajMzNjZvcXQ0N2hkd2Z6ZTJydnN5amN1ampoamo0anZidGloa2xlZzZAa3hh
c3N0cW9pYTIyLwoKSGkgUGV0ciwKClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQsIGFuZCBz
b3JyeSBmb3IgdGhlIG5vaXNlLgoKSSBtaXNzZWQgTmF2ZWVuJ3MgZWFybGllciBwYXRjaC4gSXQg
YWRkcmVzc2VzIHRoZSBzYW1lCkNPTkZJR19QUk9WRV9SQ1VfTElTVCB3YXJuaW5nIGFuZCB1c2Vz
IHRoZSBzYW1lIGxvY2tkZXAgY29uZGl0aW9uIGZvcgpyZWFkX2ZpbGVfbW9kX3N0YXRzKCksIHNv
IHBsZWFzZSBpZ25vcmUvZHJvcCBteSBkdXBsaWNhdGUgc3VibWlzc2lvbi4KClRoYW5rcywKUnVu
eXUKCg==
