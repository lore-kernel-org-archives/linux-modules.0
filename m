Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E02A8E5;
	Sat, 19 Oct 2024 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729372871; cv=none; b=aBb+PI4fhT2ELBtBznbjATDjOAkS/ALMdQXgwDKqgNMfxd34WBMaMqA2rSmPEbD60ZgB6KoeQ6pZQw5FxBCKmuNWGtrhYo3IU/LShhfrGhT3ImZAJV2mhlULI2xDeADhDDKK+TPDRrhDtjiO4PuvfeqEb208YRVovhWEwZ1OCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729372871; c=relaxed/simple;
	bh=b+ixQT+D7HXYHPXd24UWiCusqWiFBUNqqJco+ViNWM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7owT1DML1y3fTKhhETbAKFr2IKeybOb2McylEpZ+V3hJly+yQ1yPga7uds2cOUOcdIWt2wdM6ssvgJaQOv4UG4Yl/srJOiLLA8w6DZLnkmwCspH3SmGBycsvqV42RTXn9T0KYev/I7fQwD8ndsUN0IgiVRWWUIZYot+bkAxuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HBWFGXt2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBWFGXt2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dkFpBigpf/M3vHRUj/pj5SiJUX28dX7S56b9xBPIGZs=; b=HBWFGXt2CRJhwqw4oyQdPzjTsc
	mOeYySOzhZV3hZW/PcrjqiBtpI1ODrNWnkRHV6mMZUJsbeGF2Tit48wYG/GxYict0JXQkwWzhPPWZ
	83TrxYCo2s6Q1yqTFFolxkzAv5x+Udiv0+Rc6BbVU+HIoqHOlMIlovPGl6+vqQQyCrLfu8yzIv7mh
	7FRVr0UB7w82rKzLS18DBWVIuS8n6GT4+NRJVOn+Y07YxlTC8/iUnLpUUNpVRW0kmVg+W46OmIcVn
	aPFKy69qB42t26FFqxvxbyj9FGl8/7bS2mKrLfnch92hOjvm940Z2QFbXeqmeiuYajRAKwuJBdYl7
	1rOF5pag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t2Gsg-00000003wgb-0oae;
	Sat, 19 Oct 2024 21:21:02 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: sfr@canb.auug.org.au
Cc: petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] next: use new shared modules tree
Date: Sat, 19 Oct 2024 14:21:00 -0700
Message-ID: <20241019212100.940549-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Use the new shared modules tree as we have more than one
modules maintainer now.

git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Next/Trees | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Next/Trees b/Next/Trees
index 38812059087c..585cddaf8746 100644
--- a/Next/Trees
+++ b/Next/Trees
@@ -252,7 +252,7 @@ regmap		git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git#for
 sound		git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git#for-next
 ieee1394	git	https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git#for-next
 sound-asoc	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#for-next
-modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-next
+modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git#modules-next
 input		git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git#next
 block		git	git://git.kernel.dk/linux-block.git#for-next
 device-mapper	git	git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git#for-next
-- 
2.43.0

