Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7522A7F9;
	Sun, 14 Dec 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765744010; cv=none; b=S4DXOVE1/3MgR3crVsw3zRV+/e/vBrJaKSOPGs6cneC+7UcHyLN6yCPubPiFY5VH1va5HuMIxVmsYIIBsmWLyCuXwhdTqUdVUIWzYZZDnR6KWa5kmLNmVPjDcPfpSPBLpq9hbIi0/YRTfWJb4+nAe1JZXmkRql/8sURo7HcmArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765744010; c=relaxed/simple;
	bh=lYcCLuBB8dIUxHv5VC6vJ+TAUOAZB72szKWsh0PC/YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCKT0TWPmqsEt+HmWSgiAg8VzjkMCZLA4zg7GAFKNCchxC3Xr3ptrwQMnU2pcS3/vRDv7Q6cMAMO3r6aT8sNq4lxf2TWvOE0cZvQTesEVQPpcvP2Ty+2J470/9OvLVg43eVkkhRJwmc2PpKrOAKBe5XRGX5pdnYJ2jnQ/P9U2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dPYTJy0G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPYTJy0G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lYcCLuBB8dIUxHv5VC6vJ+TAUOAZB72szKWsh0PC/YU=; b=dPYTJy0GP/MVKkqXsJWbl9/Onr
	5DK9o+26tE79g8ht8s4JZNRId9LwjvojhiLWCFGL9F084/k3fDDilNArG4zVAIIiUBzoO5vwLBJiA
	WDPxOs+Wwy0JcGxEZMQd4BlEYXh54iclDGWb3alqNJCbrUGRj2vBqEnoIhUKeWz95UB79x91vlyjd
	NjhBGGmfHzkRW2oAjglZ3ow0juLE64F9qbU3CRkWTQrGTiNSr54kypXO5mA2AZbSovL2zZI2UOjdQ
	dFd4ERK5F8EeCLnlJjh89lPLyKUIYZQ5JWc+8QNcwQ/ywSQ9MVZGdpzZ5nSZNIbve84RCcEAsEfo+
	3fX+5JBQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUsg3-00000002iYj-2eFX;
	Sun, 14 Dec 2025 20:26:48 +0000
Message-ID: <ff6ace69-0b63-4da8-8a1b-7f0ab9247ed8@infradead.org>
Date: Sun, 14 Dec 2025 12:26:44 -0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] modules: moduleparam.h: add kernel-doc comments
To: linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org
References: <20251214202600.2212699-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251214202600.2212699-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry. Accidental resend. Please disregard it.

