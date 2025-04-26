Received: from smtpauth.rollernet.us (smtpauth.rollernet.us [208.79.240.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F254414
	for <linux-modules@vger.kernel.org>; Sat, 26 Apr 2025 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.79.240.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745709785; cv=none; b=PVcc91h4IaEp0dUZa1KtRyp78DeMRHLxvAt/mx7mCow+cZyIP8JeVHVT/BEV0mcJs88NOmPNiInjIS5+h8TyionoS1DxRX8bI7lr8dBoZWYZQT1aHl1vmwiiYS/kUSvq3NA355JTw29vWIE5nJzYY/uda+QIycNEi5tLBEC/Kyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745709785; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odXkz6LQbCRhlKgget0q51sW1kjh6tkA7JzpjS80gQVCSabbI59SLW0qPcpysDeR3DP1MwKkPgjmLCgtUGft/mt97VHRe8tybw0rB/p8zqGsSdDIrbvXpotbWHY5ta3lryDeViM9xOlIagqwJLWqfUnEY8UPN3b1NJTpwQ5qjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aronetics.com; spf=pass smtp.mailfrom=aronetics.com; dkim=pass (2048-bit key) header.d=aronetics.com header.i=@aronetics.com header.b=zpm+2n+A; arc=none smtp.client-ip=208.79.240.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aronetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aronetics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aronetics.com header.i=@aronetics.com header.b="zpm+2n+A"
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id 2D4BB280087D
	for <linux-modules@vger.kernel.org>; Sat, 26 Apr 2025 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aronetics.com;
	 h=from:to:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=roll2210; t=1745709350; bh=47DEQpj
	8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=zpm+2n+A9Y/cViX2MmeadrB
	g0wkgGGEC7725ty3mgBtqGvQfjBhJ68tkRhv4Dp6DNHIafCCGg1c44TVGvkWqXyL
	C/HHfCdpuarB0b4QnvjSRjbAyMxmOI4de3wqss4tpiN3xAq3gtG4W2ebRp1RwBh+
	99Xm3iRf3epyh/NzL/KxsF3FJ26Qbbfe2oT/uDsy4WBALzZa2C+IDI/PEPZNTGKF
	GopI0CIN+GqLCskIVVtFU6JuTkOM18Tp4b/wOYHIWEBuMdFjwp2wq/ihmwYDW8i/
	EHr3/U9FiZCpgtEHS3Vh6LJ0TurBvZeTrebxd2DQYfuVJeaj9hdxUNB78MbvJAg=
	=
From: <john@aronetics.com>
To: <linux-modules@vger.kernel.org>
Subject: JOIN
Date: Sat, 26 Apr 2025 19:15:44 -0400
Message-ID: <009a01dbb701$23eb8710$6bc29530$@aronetics.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adu3AOCh/EiEb1Z4RtaMUTPDgpQEcA==
Content-Language: en-us
X-Rollernet-Abuse: mailto:abuse@rollernet.us https://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 19af.680d6925.ca833.0



