Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232E139E
	for <linux-modules@vger.kernel.org>; Wed,  7 May 2025 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601128; cv=none; b=HH6eg5OQfNxqR3U7FwnX8ary5aAOGZXNew2Xj9Z/K7/+bl4SIeVy99aGSlgpQec1DaL5nkJqQeKlBXsiBcFfGWGX1HTsu8ZdcF720s3uIJNMN4VwJYew98g6UTnFPcCEyQWafT4v1VEinjLS6WbN+AY+JLlRCfsqy67xWuoo46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601128; c=relaxed/simple;
	bh=imfludp/1dq55OAaRguTMgI+tX2dTPHbE2WTBLQKWoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fwuwgxo4u3fDpj3ivitaq7Rlc8DgFMXKccaIKPAJRj6pG/+jsnioxEMr14AVid4X8lIfT3e2uEQPsTEZzNZWsevOKOpxqVvquEoulzMb9Y3WXXr0hKJL1Truq0e+KWKWvj2T4TY/R+R8tZl7dCMhdu4ZFRKTU/xCgcx/xM1HvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=np5fWw3j; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="np5fWw3j"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id EC50165FA1
	for <linux-modules@vger.kernel.org>; Wed,  7 May 2025 09:52:31 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6905:0:640:c8fc:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 5DDF3609A1;
	Wed,  7 May 2025 09:52:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MqWeW77La0U0-skZF1DXd;
	Wed, 07 May 2025 09:52:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1746600743; bh=lbg/U0srI0A6UwMC+hzWr0j6vFIPBdUwJJDfp77WRnk=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=np5fWw3jnIIBm0RRnUuRDZpjiA9Z53Xw2JCdQqVoACIA9BrENYiPg6FduFQLcJOzC
	 EHbjgah+SUbZ+lN4IxmVSOkp/GiwW47JvYizpL22Vnos9zaw6INUYNF59Ai0iw8tWf
	 DLRl0rBBu+/Zh37b7PQsBtHcEK9rtCIr0EfWTpdE=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	linux-modules@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
Subject: [PATCH] module: ensure that kobject_put() is safe for module type kobjects
Date: Wed,  7 May 2025 09:50:44 +0300
Message-ID: <20250507065044.86529-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <443b9765-3677-4bff-a6b6-a89f6c73cb67@suse.com>
References: <443b9765-3677-4bff-a6b6-a89f6c73cb67@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'lookup_or_create_module_kobject()', an internal kobject is created
using 'module_ktype'. So call to 'kobject_put()' on error handling
path causes an attempt to use an uninitialized completion pointer in
'module_kobject_release()'. In this scenario, we just want to release
kobject without an extra synchronization required for a regular module
unloading process, so adding an extra check whether 'complete()' is
actually required makes 'kobject_put()' safe.

Reported-by: syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7fb8a372e1f6add936dd
Fixes: 942e443127e9 ("module: Fix mod->mkobj.kobj potentially freed too early")
Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 kernel/params.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index e668fc90b83e..b92d64161b75 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -943,7 +943,9 @@ struct kset *module_kset;
 static void module_kobj_release(struct kobject *kobj)
 {
 	struct module_kobject *mk = to_module_kobject(kobj);
-	complete(mk->kobj_completion);
+
+	if (mk->kobj_completion)
+		complete(mk->kobj_completion);
 }
 
 const struct kobj_type module_ktype = {
-- 
2.49.0

