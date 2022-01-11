import { ActionIcon, Menu } from "@mantine/core";
import Image from "next/image";
import { useRouter } from "next/router";
import { BiUserCircle } from "react-icons/bi";

// const ProfileIcon = () => {
//   return (
//     <div
//       style={{
//         width: "32px",
//         height: "32px",
//         border: "2px solid rgb(229, 232, 235)",
//         borderRadius: "16px",
//       }}
//     >
//       <>
//         <Image className="profile-icon" src="/images/profile20.png" width="100%" height="100%" alt="" />
//         <style jsx global>{`
//           .profile-icon {
//             border-radius: 50%;
//           }
//         `}</style>
//       </>
//     </div>
//   );
// };

const Profile = () => {
  const router = useRouter();

  return (
    <Menu
      controlRefProp="ref"
      control={
        // <div
        //   style={{
        //     width: "36px",
        //     height: "36px",
        //     border: "2px solid rgb(229, 232, 235)",
        //     borderRadius: "16px",
        //   }}
        // >
        //   <>
        //     <Image className="profile-icon" src="/images/profile20.png" width="100%" height="100%" alt="" />
        //     <style jsx global>{`
        //       .profile-icon {
        //         border-radius: 50%;
        //       }
        //     `}</style>
        //   </>
        // </div>
        <ActionIcon size={36} style={{ cursor: "auto" }}>
          <BiUserCircle style={{ width: "40px", height: "40px" }} />
        </ActionIcon>
      }
      trigger="hover"
      delay={200}
    >
      <Menu.Item onClick={() => router.push("/my-collections")}>My Collections</Menu.Item>
    </Menu>
  );
};

export default Profile;
