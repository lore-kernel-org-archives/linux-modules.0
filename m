Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842AB1E573F;
	Mon, 19 May 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672743; cv=none; b=NflIbW3VJFqlUwGz35TeV65tgiw1jEDFR8a48YPIjCGoeaNRms5kCtpPWF3u5Hzk4bS6t2bKSIZ7s0knVc2T8EKFIp9QINHPD0LMIxi0lAZHYWYMDy8m/L3t7bzTUZUBaTCWPuKf7PovAAw9oLqN22bkF7qxFulpyEpd2OFdU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672743; c=relaxed/simple;
	bh=uZOe9lmbBGmuo5/Ne4Zed6Db+GO58gvc24zPWbDmp6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=olDntqB+ongvxeA23fO116Q4hFXs5GBZG9pgGaOr7iD2iCESt3CwiF9XZv3JzmoK/E6TQhnlEG6aAt4qkid0+yxROHXBwjsg9k8FSX3xRJEazcJLu8KqjJOM8hCDO5lWDtLH51YxlMuPfrpmXLXbRataOKMbopkFeMLG/k6o8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gOu2sx/1; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gOu2sx/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jo
	TivAkSBjTqIfYZ5iBOY30EupsNyTxNclneiFMNbWM=; b=gOu2sx/1vEfOzmwAOP
	pVu5u0pi4VOKX3gVQclR2Fp2ldcKFiRll5NsuLSbuZhclcPN2BSf0bHKRleVYRk5
	ksAvqWzSFhPydhNW50AWWlFeRK6KC9X3eZ+fEFrrryH8D5Dyvpr1R73UumOgoc39
	XJX292elyt5a0+ATk63E5vjOc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXgUmCXitoAHEECg--.49698S4;
	Tue, 20 May 2025 00:38:39 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	petr.pavlu@suse.com,
	mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH v2] module: release codetag section when module load fails
Date: Tue, 20 May 2025 00:38:23 +0800
Message-Id: <20250519163823.7540-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250518101212.19930-1-00107082@163.com>
References: <20250518101212.19930-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXgUmCXitoAHEECg--.49698S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry7KFWDWryxJFyUXFWxXrb_yoWDWwb_X3
	y8JryxWr1UJw409w4rt3ZagrsYgry8Gr95u3s7tay5t3W7Aw13ArnxKr9xXFn8GrZ7AFs3
	AFnxJ3Wq9r1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWBT5UUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0h1SqmgrV7WIRwAAsZ

When module load fails after memory for codetag section is ready,
codetag section memory will not be properly released. This
causes memory leak, and if next module load happens to get the
same module address, codetag may pick the uninitialized section
when manipulating tags during module unload, and leads to
"unable to handle page fault" BUG.

Closes: https://lore.kernel.org/all/20250516131246.6244-1-00107082@163.com/
Signed-off-by: David Wang <00107082@163.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2859dc3eea6..5c6ab20240a6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2829,6 +2829,7 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 {
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
+	codetag_free_module_sections(mod);
 
 	free_mod_mem(mod);
 }
-- 
2.39.2

