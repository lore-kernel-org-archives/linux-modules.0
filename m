Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63715 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbbAULhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 21 Jan 2015 06:37:45 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 3/4] testsuite: add more input cases to freadline_wrapped test
Date: Wed, 21 Jan 2015 09:37:22 -0200
Message-ID: <1421840243-26082-3-git-send-email-caio.oliveira@intel.com>
In-Reply-To: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
References: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/rootfs-pristine/test-util/freadline_wrapped-correct.txt | 4 ++++
 testsuite/rootfs-pristine/test-util/freadline_wrapped-input.txt   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/testsuite/rootfs-pristine/test-util/freadline_wrapped-correct.txt b/testsuite/rootfs-pristine/test-util/freadline_wrapped-correct.txt
index 87344ab..80c671b 100644
--- a/testsuite/rootfs-pristine/test-util/freadline_wrapped-correct.txt
+++ b/testsuite/rootfs-pristine/test-util/freadline_wrapped-correct.txt
@@ -4,3 +4,7 @@ this is a single line
 1
 three line lines in a row
 3
+this line has exactly 256 chars to make fun with the implementation, so it must have word after word after word after word after word after word after word after word after word after word after word after word after word after word until it hits 256 chars
+1
+this line is very large because it has word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word until it hits 2015 chars
+1
diff --git a/testsuite/rootfs-pristine/test-util/freadline_wrapped-input.txt b/testsuite/rootfs-pristine/test-util/freadline_wrapped-input.txt
index f84a852..1c81f91 100644
--- a/testsuite/rootfs-pristine/test-util/freadline_wrapped-input.txt
+++ b/testsuite/rootfs-pristine/test-util/freadline_wrapped-input.txt
@@ -4,3 +4,5 @@ this is a single line
 three line \
 lines \
 in a row
+this line has exactly 256 chars to make fun with the implementation, so it must have word after word after word after word after word after word after word after word after word after word after word after word after word after word until it hits 256 chars
+this line is very large because it has word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word after word until it hits 2015 chars
-- 
2.2.2

