Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1482054E9;
	Mon, 16 Dec 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369920; cv=none; b=V1MtF/D1pIl7sYFT0h3nXuapW9QKgd6crnWjw1uCSd6BsahZbOMGAb6T8If/9RSz1TNf40pXbMNojR3y6VdAujTwNpXNQfIbpTB1yPOQ79POPNPqEzaBukj2f70ajKadvBZOUziWLUaJbqY8TJWZ7hKU5RF5xybH3GykcOZM5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369920; c=relaxed/simple;
	bh=jHHrTA7ih/jyCQ+/uc6W9zu6mt08zZM88z87eEp+ahQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+UA8t7eV9ha2E+lRnyVCUApiFG/BwXR7JjaxV1bnnlMEdUBpmkRUFKtK5AZ2NfXjhp+XOIumxxzxNSZZ6WHjVLX9+E+T3tyBA2vm74iP91tJhz13ec0Oa1zqFnmZa6QCVo8tjpy+AMd9IX26CumtkBEO8VvJmptjspKJT28VIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hNg7IHbR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hNg7IHbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734369915;
	bh=jHHrTA7ih/jyCQ+/uc6W9zu6mt08zZM88z87eEp+ahQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hNg7IHbRWS/Qdbu4rJ4iCGtYloYg0fZnEum3Yi017/KLihiTszAm4qelUQO0dYZF5
	 9vaTsf7gmKCfrOcLmJ7sslf02NLG3XBnOAUNBhnUQKESdPIW9mwUy4hPUYUrpG0IVW
	 MNTov416imcPwmae4r2oNg4daX/RATYrJR9OH7Yk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 18:25:08 +0100
Subject: [PATCH 1/3] params: Prepare for 'const struct module_attribute *'
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-attr-module-v1-1-3790b53e0abf@weissschuh.net>
References: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734369915; l=1487;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jHHrTA7ih/jyCQ+/uc6W9zu6mt08zZM88z87eEp+ahQ=;
 b=yZD6mcnvdn+Hg4BhmDMmWIBtkXXlRvonLqPHDvnDOX/LRefhU+G2QA5zuq2JGf2fxprmHvBYH
 fKaluj89xQMAJKGrNNoBnd6sMWU+9dzlLv7xjvckQrTZwhtHkX876xq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The 'struct module_attribute' sysfs callbacks are about to change to
receive a 'const struct module_attribute *' parameter.
Prepare for that by avoid casting away the constness through
container_of() and using const pointers to 'struct param_attribute'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/params.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2e447f8ae183e7ec6d1815c862e0cec6572099d4..e90733824528eacc77046f85c9ab4243467ca841 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -555,13 +555,13 @@ struct module_param_attrs
 };
 
 #ifdef CONFIG_SYSFS
-#define to_param_attr(n) container_of(n, struct param_attribute, mattr)
+#define to_param_attr(n) container_of_const(n, struct param_attribute, mattr)
 
 static ssize_t param_attr_show(struct module_attribute *mattr,
 			       struct module_kobject *mk, char *buf)
 {
 	int count;
-	struct param_attribute *attribute = to_param_attr(mattr);
+	const struct param_attribute *attribute = to_param_attr(mattr);
 
 	if (!attribute->param->ops->get)
 		return -EPERM;
@@ -578,7 +578,7 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 				const char *buf, size_t len)
 {
  	int err;
-	struct param_attribute *attribute = to_param_attr(mattr);
+	const struct param_attribute *attribute = to_param_attr(mattr);
 
 	if (!attribute->param->ops->set)
 		return -EPERM;

-- 
2.47.1

