Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:55010 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966018AbcBCTIo (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:08:44 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:08:42 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 17/22] ima: remove firmware and module specific cached status info
Date: Wed,  3 Feb 2016 14:06:25 -0500
Message-Id: <1454526390-19792-18-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Each time a file is read by the kernel, the file should be re-measured and
the file signature re-appraised, based on policy.  As there is no need to
preserve the status information, this patch replaces the firmware and
module specific cache status with a generic one named read_file.

This change simplifies adding support for other files read by the kernel.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/iint.c             |  4 ++--
 security/integrity/ima/ima.h          |  3 ++-
 security/integrity/ima/ima_appraise.c | 35 ++++++++++++++++-------------------
 security/integrity/ima/ima_policy.c   |  9 ++++-----
 security/integrity/integrity.h        | 16 ++++------------
 5 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8f1ab37..345b759 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -77,7 +77,7 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_module_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	kmem_cache_free(iint_cache, iint);
 }
@@ -157,7 +157,7 @@ static void init_once(void *foo)
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_module_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0b7134c..a5d2592 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -144,9 +144,10 @@ enum ima_hooks {
 	FILE_CHECK = 1,
 	MMAP_CHECK,
 	BPRM_CHECK,
+	POST_SETATTR,
 	MODULE_CHECK,
 	FIRMWARE_CHECK,
-	POST_SETATTR
+	MAX_CHECK
 };
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index cb0d0ff..6b4694a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -74,13 +74,12 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 		return iint->ima_mmap_status;
 	case BPRM_CHECK:
 		return iint->ima_bprm_status;
-	case MODULE_CHECK:
-		return iint->ima_module_status;
-	case FIRMWARE_CHECK:
-		return iint->ima_firmware_status;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		return iint->ima_file_status;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		return iint->ima_read_status;
 	}
 }
 
@@ -95,15 +94,14 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->ima_bprm_status = status;
 		break;
-	case MODULE_CHECK:
-		iint->ima_module_status = status;
-		break;
-	case FIRMWARE_CHECK:
-		iint->ima_firmware_status = status;
-		break;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		iint->ima_file_status = status;
+		break;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		iint->ima_read_status = status;
+		break;
 	}
 }
 
@@ -117,15 +115,14 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->flags |= (IMA_BPRM_APPRAISED | IMA_APPRAISED);
 		break;
-	case MODULE_CHECK:
-		iint->flags |= (IMA_MODULE_APPRAISED | IMA_APPRAISED);
-		break;
-	case FIRMWARE_CHECK:
-		iint->flags |= (IMA_FIRMWARE_APPRAISED | IMA_APPRAISED);
-		break;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
+		break;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		iint->flags |= (IMA_READ_APPRAISED | IMA_APPRAISED);
+		break;
 	}
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cfbe86f..7571ce8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -300,13 +300,12 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 		return IMA_MMAP_APPRAISE;
 	case BPRM_CHECK:
 		return IMA_BPRM_APPRAISE;
-	case MODULE_CHECK:
-		return IMA_MODULE_APPRAISE;
-	case FIRMWARE_CHECK:
-		return IMA_FIRMWARE_APPRAISE;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		return IMA_FILE_APPRAISE;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		return IMA_READ_APPRAISE;
 	}
 }
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9a0ea4c..c7a111c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -45,18 +45,12 @@
 #define IMA_MMAP_APPRAISED	0x00000800
 #define IMA_BPRM_APPRAISE	0x00001000
 #define IMA_BPRM_APPRAISED	0x00002000
-#define IMA_MODULE_APPRAISE	0x00004000
-#define IMA_MODULE_APPRAISED	0x00008000
-#define IMA_FIRMWARE_APPRAISE	0x00010000
-#define IMA_FIRMWARE_APPRAISED	0x00020000
-#define IMA_READ_APPRAISE	0x00040000
-#define IMA_READ_APPRAISED	0x00080000
+#define IMA_READ_APPRAISE	0x00004000
+#define IMA_READ_APPRAISED	0x00008000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
-				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
-				 IMA_FIRMWARE_APPRAISE | IMA_READ_APPRAISE)
+				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
-				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
-				 IMA_FIRMWARE_APPRAISED | IMA_READ_APPRAISED)
+				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
@@ -111,8 +105,6 @@ struct integrity_iint_cache {
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
-	enum integrity_status ima_module_status:4;
-	enum integrity_status ima_firmware_status:4;
 	enum integrity_status ima_read_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
-- 
2.1.0

